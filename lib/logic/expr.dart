import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

class MathExpressionsBuilder {
  MathExpressionsBuilder() : parser = Parser();
  MathExpressionsBuilder.withParser(this.parser);

  final List<String> _list = [];
  final Parser parser;

  Expression? _expression;
  double? _value;

  double? get value => _value;

  String get expressionString =>
      _expression != null ? _expression!.toString() : _list.join('');
  set expressionString(String value) {
    _list.clear();
    _list.addAll(value.split(''));
  }

  bool get isParenthesesOpen => expressionString.lastIndexOf('(') != -1;

  bool get canCloseParentheses {
    if (!isParenthesesOpen) return false;

    final openi = expressionString.lastIndexOf('(');
    final closei = expressionString.indexOf(')', openi < 0 ? 0 : openi);
    return closei == -1;
  }

  bool get shouldAddNumber {
    if (_list.length == 0) {
      return true;
    }
    return !RegExp(r'^\d+$').hasMatch(_list.last);
  }

  void clear() {
    _list.clear();
    _expression = null;
    _value = null;
  }

  void push(String value) {
    _list.add(value);
    _expression = null;
    _value = null;
  }

  void remove() {
    _list.removeLast();
  }

  void execute() {
    try {
      _expression = parser.parse(_list.join(''));

      final cm = ContextModel()..bindVariable(Variable('Π'), Number(pi));
      _value = _expression!.evaluate(EvaluationType.REAL, cm);
    } catch (e) {}
  }

  @override
  String toString() =>
      _value == null ? expressionString : '$expressionString = ${_value!}';
}
