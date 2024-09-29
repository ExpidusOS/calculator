import 'package:calculator/main.dart';
import 'package:expidus/expidus.dart';
import 'package:flutter/material.dart' show PopupMenuItem;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutView extends StatelessWidget {
  const AboutView({ super.key });
  
  @override
  Widget build(BuildContext context) =>
    ExpidusScaffold(
      title: AppLocalizations.of(context)!.viewAbout,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AboutWindow(
            appIcon: Image.asset('assets/imgs/icon.webp'),
            appName: AppLocalizations.of(context)!.applicationTitleFull,
            appVersion: CalculatorApp.getPubspec(context).version.toString(),
          ),
        ),
      ),
    );
}
