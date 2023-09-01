import 'package:libtokyo_flutter/libtokyo.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.style,
  });

  final Widget child;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) =>
    Center(
      child: Container(
        width: 80,
        height: 80,
        child: OutlinedButton(
          child: child,
          onPressed: onPressed,
          style: style ?? ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.tertiary),
          ),
        ),
      ),
    );
}
