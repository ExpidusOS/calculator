import 'package:calculator/logic.dart';
import 'package:calculator/main.dart';
import 'package:expidus/expidus.dart';
import 'package:flutter/material.dart' show Divider, BackButton;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({ super.key });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SharedPreferences preferences;
  bool optInErrorReporting = false;

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
  }

  @override
  Widget build(BuildContext context) =>
    ExpidusScaffold(
      title: AppLocalizations.of(context)!.viewSettings,
      start: [const BackButton()],
      body: PreferencesGroup(
        children: [
          ...(const String.fromEnvironment('SENTRY_DSN', defaultValue: '').isNotEmpty ? [
            SwitchRow(
              title: AppLocalizations.of(context)!.settingsOptInErrorReportingTitle,
              subtitle: AppLocalizations.of(context)!.settingsOptInErrorReportingSubtitle,
              value: optInErrorReporting,
              onChanged: (value) {
                preferences.setBool(
                  CalculatorSettings.optInErrorReporting.name,
                  value);

                setState(() {
                  optInErrorReporting = value;
                });
              }
            ),
          ] : []),
          ActionRow(
            title: AppLocalizations.of(context)!.settingsRestore,
            onActivated: () {
              preferences.clear();

              setState(() {
                _loadSettings();
                CalculatorApp.reload(context);
              });
            },
          ),
          const Divider(),
          ActionRow(
            title: AppLocalizations.of(context)!.viewPrivacy,
            onActivated: () =>
              Navigator.pushNamed(context, '/privacy'),
          ),
          ActionRow(
            title: AppLocalizations.of(context)!.viewAbout,
            onActivated: () =>
            Navigator.pushNamed(context, '/about'),
          ),
        ],
      ),
    );
}
