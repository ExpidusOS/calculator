import 'package:expidus/expidus.dart';

class CalculatorBox extends StatelessWidget {
  const CalculatorBox({
    super.key,
    this.value = '',
    this.onChanged,
  });

  final String value;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).colorScheme.background,
        child: TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
        ),
      );
}
