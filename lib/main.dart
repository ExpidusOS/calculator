import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:calculator/logic.dart';
import 'package:calculator/views.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec/pubspec.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final kCommitHash = (const String.fromEnvironment('COMMIT_HASH', defaultValue: 'AAAAAAA')).substring(0, 7);

Future<void> _runMain({
  required bool isSentry,
  required PubSpec pubspec,
}) async {
  final app = CalculatorApp(
    isSentry: isSentry,
    pubspec: pubspec,
  );
  runApp(isSentry ? DefaultAssetBundle(bundle: SentryAssetBundle(), child: app) : app);

  if (!kIsWeb) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
        doWhenWindowReady(() {
          final win = appWindow;
          const initialSize = Size(600, 450);

          win.minSize = initialSize;
          win.size = initialSize;
          win.alignment = Alignment.center;
          win.show();
        });
        break;
      default:
        break;
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pinfo = await PackageInfo.fromPlatform();

  final pubspec = PubSpec.fromYamlString(await rootBundle.loadString('pubspec.yaml')).copy(
    version: Version.parse("${pinfo.version}+$kCommitHash"),
  );

  const sentryDsn = String.fromEnvironment('SENTRY_DSN', defaultValue: '');
  final prefs = await SharedPreferences.getInstance();

  if (sentryDsn.isNotEmpty && (prefs.getBool(CalculatorSettings.optInErrorReporting.name) ?? false)) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.tracesSampleRate = 1.0;
        options.release = 'com.expidusos.calculator@${pubspec.version!}';
        options.dist = pubspec.version!.toString();

        if (kDebugMode) {
          options.environment = 'debug';
        } else if (kProfileMode) {
          options.environment = 'profile';
        } else if (kReleaseMode) {
          options.environment = 'release';
        }
      },
      appRunner: () => _runMain(
        isSentry: true,
        pubspec: pubspec,
      ).catchError((error, trace) {
        reportError(error, trace: trace);
      }),
    );
  } else {
    _runMain(
      isSentry: false,
      pubspec: pubspec,
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({
    super.key,
    this.isSentry = false,
    required this.pubspec,
  });

  final bool isSentry;
  final PubSpec pubspec;

  @override
  State<CalculatorApp> createState() => CalculatorAppState();

  static bool isSentryOnContext(BuildContext context) => context.findAncestorWidgetOfExactType<CalculatorApp>()!.isSentry;
  static PubSpec getPubSpec(BuildContext context) => context.findAncestorWidgetOfExactType<CalculatorApp>()!.pubspec;
  static Future<void> reload(BuildContext context) => context.findAncestorStateOfType<CalculatorAppState>()!.reload();
}

class CalculatorAppState extends State<CalculatorApp> {
  late SharedPreferences preferences;
  ColorScheme? colorScheme;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) => setState(() {
      preferences = prefs;
      _loadSettings();
    })).catchError((error, trace) {
      reportError(error, trace: trace);
    });
  }

  Future<void> reload() async {
    await preferences.reload();
    setState(() => _loadSettings());
  }

  void _loadSettings() {
    colorScheme = ColorScheme.values.asNameMap()[preferences.getString(CalculatorSettings.colorScheme.name) ?? 'night'];
  }

  @override
  Widget build(BuildContext context) =>
    MultiProvider(
      providers: [
        Provider(create: (context) => preferences),
      ],
      child: TokyoApp(
        title: 'Calculator',
        themeMode: colorScheme == ColorScheme.day ? ThemeMode.light : ThemeMode.dark,
        colorScheme: colorScheme,
        colorSchemeDark: colorScheme,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.applicationTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: widget.isSentry ? [
          SentryNavigatorObserver(
            setRouteNameAsTransaction: true,
          ),
        ] : null,
        routes: {
          '/': (context) => const MainView(),
          '/about': (context) => const AboutView(),
          '/privacy': (context) => const PrivacyView(),
          '/settings': (context) => const SettingsView(),
        },
      ),
    );
}
