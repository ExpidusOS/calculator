import 'package:calculator/logic.dart';
import 'package:calculator/views.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({
    super.key,
  });

  @override
  State<CalculatorApp> createState() => CalculatorAppState();
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
      // TODO
    });
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
        routes: {
          '/': (context) => MainView(),
        },
      ),
    );
}
