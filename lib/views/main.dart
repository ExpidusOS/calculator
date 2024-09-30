import 'package:calculator/widgets.dart';
import 'package:expidus/expidus.dart';
import 'package:flutter/material.dart' show PopupMenuDivider, PopupMenuItem;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final type = ValueNotifier(CalculatorViewType.standard);

  late FlapController _flapController;

  @override
  void initState() {
    super.initState();

    _flapController = FlapController();
    _flapController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => ExpidusScaffold(
        title: type.value == CalculatorViewType.standard
            ? AppLocalizations.of(context)!.modeStandard
            : AppLocalizations.of(context)!.modeGraphing,
        flapController: _flapController,
        flap: (isDrawer) => Sidebar(
          currentIndex: switch (type.value) {
            CalculatorViewType.standard => 0,
            CalculatorViewType.graphing => 1,
          },
          isDrawer: isDrawer,
          children: [
            SidebarItem(
              label: AppLocalizations.of(context)!.modeStandard,
            ),
            SidebarItem(
              label: AppLocalizations.of(context)!.modeGraphing,
            ),
            SidebarItem(
              label: AppLocalizations.of(context)!.viewSettings,
            ),
          ],
          onSelected: (i) {
            setState(() {
              switch (i) {
                case 0:
                  type.value = CalculatorViewType.standard;
                  break;
                case 1:
                  type.value = CalculatorViewType.graphing;
                  break;
                case 2:
                  Navigator.pushNamed(context, '/settings');
                  break;
              }
            });
          },
        ),
        body: CalculatorView(value: type),
      );
}
