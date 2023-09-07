import 'package:libtokyo_flutter/libtokyo.dart';

class CalculatorBox extends StatelessWidget {
  const CalculatorBox({
    super.key,
    this.value = '',
    this.onChanged,
  });

  final String value;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) =>
    Material(
      color: Theme.of(context).colorScheme.background,
      child: TextField(
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        controller: TextEditingController(text: value),
        cursorColor: Theme.of(context).colorScheme.primary,
        onChanged: onChanged,
        showCursor: true,
      ),
    );
}
