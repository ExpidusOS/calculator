import 'package:expidus/expidus.dart';
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

  CalculatorViewType get type => isState ? _type! : widget.value!.value;

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
        return BasicCalculator(
          onChanged: (value) => setState(() {}),
        );
    }
  }
}
