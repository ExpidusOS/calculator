import 'package:flutter/material.dart';
import 'package:libtokyo_flutter/libtokyo.dart' hide Color;

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.style,
    this.constrained = false,
  });

  final Widget child;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final bool constrained;

  Widget _buildMain(BuildContext context) =>
    OutlinedButton(
      child: child,
      onPressed: onPressed,
      style: style ?? ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color.lerp(
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.background,
            0.25
          )
        ),
      ),
    );

  @override
  Widget build(BuildContext context) =>
    constrained ? Center(
      child: Container(
        width: 80,
        height: 80,
        child: _buildMain(context),
      ),
    ) : _buildMain(context);
}
