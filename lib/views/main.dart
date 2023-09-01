import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:calculator/widgets.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:libtokyo_flutter/libtokyo.dart';

class MainView extends StatelessWidget {
  const MainView({ super.key });

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      windowBar: WindowBar.shouldShow(context) ? WindowBar(
        leading: Image.asset('assets/imgs/icon.png'),
        title: const Text('Calculator'), // TODO: i18n
      ) : null,
      body: AdaptiveLayout(
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('smallBody'),
              builder: (_) => const BasicCalculator(),
            ),
          }
        ),
      ),
    );
}
