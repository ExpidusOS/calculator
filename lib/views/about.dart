import 'package:calculator/main.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:libtokyo_flutter/widgets/about_page_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutView extends StatelessWidget {
  const AboutView({ super.key });
  
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      windowBar: WindowBar.shouldShow(context) ? WindowBar(
        leading: Image.asset('assets/imgs/icon.webp'),
        title: Text(AppLocalizations.of(context)!.applicationTitle),
      ) : null,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.viewAbout),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AboutPageBuilder(
            appTitle: AppLocalizations.of(context)!.applicationTitleFull,
            appDescription: CalculatorApp.getPubSpec(context).description!,
            pubspec: CalculatorApp.getPubSpec(context),
          ),
        ),
      ),
    );
}
