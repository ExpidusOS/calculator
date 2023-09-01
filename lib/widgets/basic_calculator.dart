import 'package:libtokyo_flutter/libtokyo.dart';
import 'calculator_button.dart';

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({ super.key });

  @override
  State<BasicCalculator> createState() => _BasicCalculator();
}

class _BasicCalculator extends State<BasicCalculator> {
  String value = '';

  @override
  Widget build(BuildContext context) =>
    Column(
      children: [
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
        ),
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
              onPressed: () =>
                setState(() {
                  value = '';
                }),
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
              onPressed: () =>
                setState(() {
                  value += '7';
                }),
            ),
            CalculatorButton(
              child: Text(
                '8',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () =>
                setState(() {
                  value += '8';
                }),
            ),
            CalculatorButton(
              child: Text(
                '9',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () =>
                setState(() {
                  value += '9';
                }),
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
              onPressed: () =>
                setState(() {
                  value += '4';
                }),
            ),
            CalculatorButton(
              child: Text(
                '5',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () =>
                setState(() {
                  value += '5';
                }),
            ),
            CalculatorButton(
              child: Text(
                '6',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () =>
                setState(() {
                  value += '6';
                }),
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
              onPressed: () =>
                setState(() {
                  value += '1';
                }),
            ),
            CalculatorButton(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () =>
                setState(() {
                  value += '2';
                }),
            ),
            CalculatorButton(
              child: Text(
                '3',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () =>
                setState(() {
                  value += '3';
                }),
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
              onPressed: () =>
                setState(() {
                  value += '0';
                }),
            ),
            CalculatorButton(
              child: Text(
                '.',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () =>
                setState(() {
                  value += '.';
                }),
            ),
            CalculatorButton(
              child: Icon(
                Icons.backspace,
                size: Theme.of(context).textTheme.headlineLarge!.fontSize,
                color: Theme.of(context).colorScheme.background,
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
          ],
        ),
      ],
    );
}
