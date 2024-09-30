import 'package:calculator/logic.dart';
import 'package:expidus/expidus.dart';
import 'package:flutter/material.dart'
    show ButtonStyle, Icons, MaterialStatePropertyAll;
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
  final builder = MathExpressionsBuilder();

  void _update() {
    if (widget.onChanged != null) {
      widget.onChanged!(builder.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CalculatorBox(
            value: builder.toString(),
            onChanged: (value) => setState(() {
              builder.expressionString = value;
            }),
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisExtent: 65),
            children: [
              CalculatorButton(
                child: Text(
                  '√',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  if (builder.shouldAddNumber) {
                    builder.push('sqrt(');
                    _update();
                  }
                },
              ),
              CalculatorButton(
                child: Text(
                  'Π',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('Π');
                  _update();
                },
              ),
              CalculatorButton(
                child: Text(
                  '^',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  if (!builder.shouldAddNumber) {
                    builder.push('^');
                    _update();
                  }
                },
              ),
              CalculatorButton(
                child: Text(
                  '!',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('!');
                  _update();
                },
              ),
              CalculatorButton(
                child: Text(
                  'AC',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.clear();
                  _update();
                },
              ),
              CalculatorButton(
                child: Text(
                  '( )',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push(builder.canCloseParentheses ? ')' : '(');
                  _update();
                },
              ),
              CalculatorButton(
                child: Text(
                  '%',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('%');
                  _update();
                },
              ),
              CalculatorButton(
                child: Text(
                  '÷',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('/');
                  _update();
                },
              ),
              CalculatorButton(
                  child: Text(
                    '7',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('7');
                    _update();
                  }),
              CalculatorButton(
                  child: Text(
                    '8',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('8');
                    _update();
                  }),
              CalculatorButton(
                  child: Text(
                    '9',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('9');
                    _update();
                  }),
              CalculatorButton(
                child: Text(
                  '✕',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('*');
                  _update();
                },
              ),
              CalculatorButton(
                  child: Text(
                    '4',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('4');
                    _update();
                  }),
              CalculatorButton(
                  child: Text(
                    '5',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('5');
                    _update();
                  }),
              CalculatorButton(
                  child: Text(
                    '6',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('6');
                    _update();
                  }),
              CalculatorButton(
                child: Text(
                  '−',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('-');
                  _update();
                },
              ),
              CalculatorButton(
                  child: Text(
                    '1',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('1');
                    _update();
                  }),
              CalculatorButton(
                  child: Text(
                    '2',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('2');
                    _update();
                  }),
              CalculatorButton(
                  child: Text(
                    '3',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('3');
                    _update();
                  }),
              CalculatorButton(
                child: Text(
                  '+',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('+');
                  _update();
                },
              ),
              CalculatorButton(
                  child: Text(
                    '0',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                  onPressed: () {
                    builder.push('0');
                    _update();
                  }),
              CalculatorButton(
                child: Text(
                  '.',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.push('.');
                  _update();
                },
              ),
              CalculatorButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color.lerp(
                        Theme.of(context).colorScheme.error,
                        Theme.of(context).colorScheme.background,
                        0.25))),
                onPressed: () => setState(() {
                  builder.remove();
                }),
                child: Icon(
                  Icons.backspace,
                  size: Theme.of(context).textTheme.displayMedium!.fontSize,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              CalculatorButton(
                child: Text(
                  '=',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
                onPressed: () {
                  builder.execute();
                  _update();
                },
              ),
            ]
                .map((child) => Padding(
                      padding: const EdgeInsets.all(2),
                      child: child,
                    ))
                .toList(),
          ),
        ],
      );
}
