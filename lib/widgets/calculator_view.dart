import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'basic_calculator.dart';

enum CalculatorViewType {
  standard
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
  Widget build(BuildContext context) =>
    AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
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
