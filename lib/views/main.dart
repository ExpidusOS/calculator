import 'package:calculator/widgets.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainView extends StatefulWidget {
  const MainView({ super.key });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final type = ValueNotifier(CalculatorViewType.standard);

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      windowBar: WindowBar.shouldShow(context) ? WindowBar(
        leading: Image.asset('assets/imgs/icon.webp'),
        title: Text(AppLocalizations.of(context)!.applicationTitle),
      ) : null,
      appBar: AppBar(
        title: Text(
          type.value == CalculatorViewType.standard
            ? AppLocalizations.of(context)!.modeStandard
            : AppLocalizations.of(context)!.modeGraphing
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
              PopupMenuItem(
                value: CalculatorViewType.standard,
                child: Text(AppLocalizations.of(context)!.modeStandard),
              ),
              PopupMenuItem(
                value: CalculatorViewType.graphing,
                child: Text(AppLocalizations.of(context)!.modeGraphing),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: '/settings',
                child: Text(AppLocalizations.of(context)!.viewSettings),
              ),
            ],
            onSelected: (value) =>
              setState(() {
                if (value is CalculatorViewType) {
                  type.value = value;
                } else if (value is String) {
                  Navigator.pushNamed(context, value);
                }
              }),
          ),
        ],
      ),
      body: CalculatorView(value: type),
    );
}
