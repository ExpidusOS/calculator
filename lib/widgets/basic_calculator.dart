import 'package:libtokyo_flutter/libtokyo.dart';
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
  String _value = '';

  void _update(String value) {
    setState(() {
      _value = value;
      if (widget.onChanged != null) {
        widget.onChanged!(_value);
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
    Column(
      children: [
        CalculatorBox(value: _value),
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
              onPressed: () => _update(''),
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
              onPressed: () => _update(_value + '7'),
            ),
            CalculatorButton(
              child: Text(
                '8',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(_value + '8'),
            ),
            CalculatorButton(
              child: Text(
                '9',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(_value + '9'),
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
              onPressed: () => _update(_value + '4'),
            ),
            CalculatorButton(
              child: Text(
                '5',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(_value + '5'),
            ),
            CalculatorButton(
              child: Text(
                '6',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(_value + '6'),
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
              onPressed: () => _update(_value + '1'),
            ),
            CalculatorButton(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(_value + '2'),
            ),
            CalculatorButton(
              child: Text(
                '3',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(_value + '3'),
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
              onPressed: () => _update(_value + '0'),
            ),
            CalculatorButton(
              child: Text(
                '.',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              onPressed: () => _update(_value + '.'),
            ),
            CalculatorButton(
              child: Icon(
                Icons.backspace,
                size: Theme.of(context).textTheme.headlineLarge!.fontSize,
                color: Theme.of(context).colorScheme.background,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.error),
              ),
              onPressed: () {
                if (_value.length > 0) {
                  _update(_value.substring(0, _value.length - 1));
                }
              },
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
