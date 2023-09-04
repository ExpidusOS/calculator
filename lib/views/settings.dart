import 'package:calculator/logic.dart';
import 'package:calculator/main.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({ super.key });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SharedPreferences preferences;
  bool optInErrorReporting = false;
  ColorScheme colorScheme = ColorScheme.night;

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

  void _loadSettings() {
    optInErrorReporting = preferences.getBool(CalculatorSettings.optInErrorReporting.name) ?? false;
    colorScheme = ColorScheme.values.asNameMap()[preferences.getString(CalculatorSettings.colorScheme.name) ?? 'night']!;
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      windowBar: WindowBar.shouldShow(context) ? WindowBar(
        leading: Image.asset('assets/imgs/icon.png'),
        title: const Text('Calculator'), // TODO: i18n
      ) : null,
      appBar: AppBar(
        title: const Text('Settings'), // TODO: i18n
      ),
      body: ListTileTheme(
        tileColor: Theme.of(context).cardTheme.color
          ?? Theme.of(context).cardColor,
        shape: Theme.of(context).cardTheme.shape,
        contentPadding: Theme.of(context).cardTheme.margin,
        child: ListView(
          children: [
            ListTile(
              title: const Text('Theme'),
              onTap: () =>
                showDialog<ColorScheme>(
                  context: context,
                  builder: (context) =>
                    Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            RadioListTile(
                              title: const Text('Storm'), // TODO: i18n
                              value: ColorScheme.storm,
                              groupValue: colorScheme,
                              onChanged: (value) => Navigator.pop(context, value),
                            ),
                            RadioListTile(
                              title: const Text('Night'), // TODO: i18n
                              value: ColorScheme.night,
                              groupValue: colorScheme,
                              onChanged: (value) => Navigator.pop(context, value),
                            ),
                            RadioListTile(
                              title: const Text('Moon'), // TODO: i18n
                              value: ColorScheme.moon,
                              groupValue: colorScheme,
                              onChanged: (value) => Navigator.pop(context, value),
                            ),
                            RadioListTile(
                              title: const Text('Day'), // TODO: i18n
                              value: ColorScheme.day,
                              groupValue: colorScheme,
                              onChanged: (value) => Navigator.pop(context, value),
                            ),
                          ],
                        ),
                      ),
                    ),
                ).then((value) {
                  if (value != null) {
                    preferences.setString(
                      CalculatorSettings.colorScheme.name,
                      value!.name
                    );

                    setState(() {
                      colorScheme = value!;
                      CalculatorApp.reload(context);
                    });
                  }
                }),
            ),
            ...(const String.fromEnvironment('SENTRY_DSN', defaultValue: '').isNotEmpty ? [
              SwitchListTile(
                title: const Text('Opt-in to error reporting via Sentry'), // TODO: i18n
                subtitle: const Text('Will take effect after restarting the application'), // TODO: i18n
                value: optInErrorReporting,
                onChanged: (value) {
                  preferences.setBool(
                    CalculatorSettings.optInErrorReporting.name,
                    value!
                  );

                  setState(() {
                    optInErrorReporting = value!;
                  });
                }
              ),
            ] : []),
            ListTile(
              title: Text('Restore default settings'),
              onTap: () {
                preferences.clear();

                setState(() {
                  _loadSettings();
                  CalculatorApp.reload(context);
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Privacy Policy'), // TODO: i18n
              onTap: () =>
                Navigator.pushNamed(context, '/privacy'),
            ),
            ListTile(
              title: const Text('About'), // TODO: i18n
              onTap: () =>
                Navigator.pushNamed(context, '/about'),
            ),
          ],
        ),
      ),
    );
}
