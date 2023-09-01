import 'package:libtokyo_flutter/libtokyo.dart';

class CalculatorBox extends StatelessWidget {
  const CalculatorBox({
    super.key,
    this.value = '',
  });

  final String value;

  @override
  Widget build(BuildContext context) =>
    Material(
      color: Theme.of(context).colorScheme.primary,
      child: TextField(
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
          color: Theme.of(context).colorScheme.background,
        ),
        controller: TextEditingController(text: value),
        cursorColor: Theme.of(context).colorScheme.primary,
        readOnly: true,
        showCursor: true,
      ),
    );
}
