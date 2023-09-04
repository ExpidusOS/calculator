import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:calculator/widgets.dart';
import 'package:libtokyo_flutter/libtokyo.dart';

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
        leading: Image.asset('assets/imgs/icon.png'),
        title: const Text('Calculator'), // TODO: i18n
      ) : null,
      appBar: AppBar(
        title: Text('${type.value.name.substring(0, 1).toUpperCase()}${type.value.name.substring(1)}'), // TODO: i18n
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
              PopupMenuItem(
                value: CalculatorViewType.standard,
                child: const Text('Standard'), // TODO: i18n
              ),
              PopupMenuItem(
                value: CalculatorViewType.graphing,
                child: const Text('Graphing'), // TODO: i18n
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: '/settings',
                child: const Text('Settings'), // TODO: i18n
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
