import 'package:calculator/logic.dart';
import 'package:flutter/material.dart';
import 'package:libtokyo_flutter/libtokyo.dart' hide Color;
import 'calculator_box.dart';
import 'calculator_button.dart';

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({
    super.key,
    this.onChanged,
  });

  final ValueChanged<String>? onChanged;

  @override
  State<BasicCalculator> createState() => _BasicCalculator();
}

class _BasicCalculator extends State<BasicCalculator> {
  CalculatorMachine machine = CalculatorMachine();

  void _update() {
    if (widget.onChanged != null) {
      widget.onChanged!(machine.toString());
    }
  }

  @override
  Widget build(BuildContext context) =>
    Column(
      children: [
        CalculatorBox(value: machine.toString()),
        GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 95
          ),
          children: [
            CalculatorButton(
              child: Text(
                '√',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '𐍀',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '^',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '!',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                'AC',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {
                machine.reset();
                _update();
              },
            ),
            CalculatorButton(
              child: Text(
                '( )',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '%',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '÷',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '7',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '8',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '9',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '✕',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '4',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '5',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '6',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '−',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '1',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '3',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '+',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
            CalculatorButton(
              child: Text(
                '0',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Text(
                '.',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(),
            ),
            CalculatorButton(
              child: Icon(
                Icons.backspace,
                size: Theme.of(context).textTheme.headlineLarge!.fontSize,
                color: Theme.of(context).colorScheme.background,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color.lerp(
                  Theme.of(context).colorScheme.error,
                  Theme.of(context).colorScheme.background,
                  0.25
                ))
              ),
              onPressed: () {},
            ),
            CalculatorButton(
             child: Text(
                '=',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () {},
            ),
          ].map((child) =>
            Padding(
              padding: const EdgeInsets.all(2),
              child: child,
            )
          ).toList(),
        ),
      ],
    );
}
