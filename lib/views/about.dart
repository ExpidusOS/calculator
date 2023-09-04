import 'package:calculator/main.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:libtokyo_flutter/widgets/about_page_builder.dart';

class AboutView extends StatelessWidget {
  const AboutView({ super.key });
  
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      windowBar: WindowBar.shouldShow(context) ? WindowBar(
        leading: Image.asset('assets/imgs/icon.png'),
        title: const Text('Calculator'), // TODO: i18n
      ) : null,
      appBar: AppBar(
        title: const Text('About'), // TODO: i18n
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AboutPageBuilder(
            appTitle: 'ExpidusOS Calculator', // TODO: i18n
            appDescription: CalculatorApp.getPubSpec(context).description!,
            pubspec: CalculatorApp.getPubSpec(context),
          ),
        ),
      ),
    );
}
