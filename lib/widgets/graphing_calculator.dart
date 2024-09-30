import 'dart:ui';
import 'package:expidus/expidus.dart';
import 'package:math_expressions/math_expressions.dart';

class _GraphingCalculatorGraph extends CustomPainter {
  const _GraphingCalculatorGraph({
    required this.context,
    this.expression,
  });

  final BuildContext context;
  final Expression? expression;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Theme.of(context).colorScheme.surface);

    final center = size / 2;

    canvas.drawLine(
        Offset(center.width, 0.0),
        Offset(center.width, size.height),
        Paint()
          ..color = Theme.of(context).colorScheme.tertiary
          ..strokeWidth = 4);

    canvas.drawLine(
        Offset(0, center.height),
        Offset(size.width, center.height),
        Paint()
          ..color = Theme.of(context).colorScheme.tertiary
          ..strokeWidth = 4);

    final points = <Offset>[];
    if (expression != null) {
      final expr = expression!;
      final x = Variable('x');
      final y = Variable('y');

      for (var xiter = center.width; xiter >= -center.width; xiter--) {
        try {
          final cm = ContextModel()
            ..bindVariable(x, Number(xiter))
            ..bindVariable(y, Number(0));

          final yiter = expr.evaluate(EvaluationType.REAL, cm);
          if (!yiter.isNaN && yiter.isFinite)
            points.add(
                Offset(xiter + center.width, (yiter * -1) + center.height));
        } catch (ex) {
          // No action needed
        }
      }
    }

    canvas.drawPoints(PointMode.polygon, points,
        Paint()..color = Theme.of(context).colorScheme.tertiary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      expression != (oldDelegate as _GraphingCalculatorGraph).expression;
}

class GraphingCalculator extends StatefulWidget {
  const GraphingCalculator({super.key});

  @override
  State<GraphingCalculator> createState() => _GraphingCalculatorState();
}

class _GraphingCalculatorState extends State<GraphingCalculator> {
  Expression? _expr;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: Theme.of(context).textTheme.displayLarge!.fontSize,
            child: Material(
              color: Theme.of(context).colorScheme.background,
              child: TextField(onChanged: (value) {
                final parser = Parser();
                setState(() {
                  try {
                    _expr = parser.parse(value);
                  } catch (e) {
                    // No action needed
                  }
                });
              }),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) => CustomPaint(
              size: Size(constraints.maxWidth,
                  MediaQuery.sizeOf(context).height - 110),
              painter: _GraphingCalculatorGraph(
                context: context,
                expression: _expr,
              ),
            ),
          ),
        ],
      );
}
