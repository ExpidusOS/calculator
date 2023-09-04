import 'package:calculator/logic.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' hide Text;
import 'package:url_launcher/url_launcher_string.dart';

class _MarkdownConstantPadding extends MarkdownPaddingBuilder {
  _MarkdownConstantPadding({ required this.padding }) : super();

  final EdgeInsets padding;

  @override
  EdgeInsets getPadding() => padding;
}

class PrivacyView extends StatelessWidget {
  const PrivacyView({ super.key });

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      windowBar: WindowBar.shouldShow(context) ? WindowBar(
        leading: Image.asset('assets/imgs/icon.png'),
        title: Text(AppLocalizations.of(context)!.applicationTitle), // TODO: i18n
      ) : null,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.viewPrivacy),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: rootBundle.loadString('PRIVACY.md'),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error!.toString());
            }

            if (snapshot.hasData) {
              return MarkdownBody(
                data: snapshot.data!,
                extensionSet: ExtensionSet.gitHubFlavored,
                styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                paddingBuilders: {
                  'h1': _MarkdownConstantPadding(padding: const EdgeInsets.all(8.0)),
                  'h2': _MarkdownConstantPadding(padding: const EdgeInsets.all(8.0)),
                  'p': _MarkdownConstantPadding(padding: const EdgeInsets.all(8.0)),
                },
                onTapLink: (text, href, title) {
                  if (href != null) {
                    launchUrlString(href!).catchError((error, trace) => reportError(error, trace: trace));
                  }
                },
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
}
