import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'basic_calculator.dart';
import 'graphing_calculator.dart';

enum CalculatorViewType {
  standard,
  graphing,
}

class CalculatorView extends StatefulWidget {
  const CalculatorView({
    super.key,
    this.value,
  });

  final ValueNotifier<CalculatorViewType>? value;

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  CalculatorViewType? _type;
  String _value = '';

  bool get isState => widget.value == null && _type != null;
  bool get isStateless => widget.value != null && _type == null;

  set type(CalculatorViewType t) {
    if (isState) {
      setState(() {
        _type = t;
      });
    } else if (isStateless) {
      widget.value!.value = t;
    }
  }

  CalculatorViewType get type =>
    isState ? _type! : widget.value!.value;

  @override
  void initState() {
    super.initState();

    if (widget.value == null) {
      _type = CalculatorViewType.standard;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CalculatorViewType.graphing:
        return const GraphingCalculator();
      case CalculatorViewType.standard:
        return AdaptiveLayout(
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('smallBody'),
                builder: (_) =>
                  BasicCalculator(
                    onChanged: (value) =>
                      setState(() {
                        _value = value;
                      }),
                  ),
              ),
            },
          ),
        );
    }
  }
}
