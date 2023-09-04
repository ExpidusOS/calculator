import 'dart:ui';
import 'package:libtokyo_flutter/libtokyo.dart';
import 'package:math_expressions/math_expressions.dart';

class _GraphingCalculatorGraph extends CustomPainter {
  const _GraphingCalculatorGraph({
    required this.context,
    this.expression,
  });

  final BuildContext context;
  final Expression? expression;

  @override
  void paint(Canvas canvas, Size ogSize) {
    final size = Size(ogSize.width, MediaQuery.sizeOf(context).height);
    canvas.drawPaint(
      Paint()
        ..color = Theme.of(context).colorScheme.background
    );

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    canvas.drawLine(
      Offset(centerX, 0.0),
      Offset(centerX, size.height),
      Paint()
        ..color = Theme.of(context).colorScheme.secondary
        ..strokeWidth = 4
    );

    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      Paint()
        ..color = Theme.of(context).colorScheme.secondary
        ..strokeWidth = 4
    );

    final points = <Offset>[];
    if (expression != null) {
      final expr = expression!;
      final x = Variable('x');
      final y = Variable('y');

      for (var xiter = centerX; xiter >= -centerX; xiter--) {
        try {
          final cm = ContextModel()
            ..bindVariable(x, Number(xiter))
            ..bindVariable(y, Number(0));

          final yiter = expr.evaluate(EvaluationType.REAL, cm);
          if (!yiter.isNaN && yiter.isFinite) points.add(Offset(xiter + centerX, (yiter * -1) + centerY));
        } catch (ex) {
          // No action needed
        }
      }
    }

    canvas.drawPoints(
      PointMode.polygon,
      points,
      Paint()
        ..color = Theme.of(context).colorScheme.primary
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => expression != (oldDelegate as _GraphingCalculatorGraph).expression;
}

class GraphingCalculator extends StatefulWidget {
  const GraphingCalculator({ super.key });

  @override
  State<GraphingCalculator> createState() => _GraphingCalculatorState();
}

class _GraphingCalculatorState extends State<GraphingCalculator> {
  Expression? _expr;

  @override
  Widget build(BuildContext context) =>
    Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          child: CustomPaint(
            painter: _GraphingCalculatorGraph(
              context: context,
              expression: _expr,
            ),
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: Theme.of(context).textTheme.displayLarge!.fontSize,
          child: Material(
            color: Theme.of(context).colorScheme.background,
            child: TextField(
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              cursorColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                final parser = Parser();
                setState(() {
                  try {
                    _expr = parser.parse(value);
                  } catch (e) {
                    // No action needed
                  }
                });
              }
            ),
          ),
        ),
      ],
    );
}
