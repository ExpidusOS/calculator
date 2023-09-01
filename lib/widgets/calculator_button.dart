import 'package:libtokyo_flutter/libtokyo.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) =>
    Center(
      child: Container(
        width: 80,
        height: 80,
        child: OutlinedButton(
          child: child,
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.tertiary),
          ),
        ),
      ),
    );
}
