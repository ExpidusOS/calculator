import 'package:flutter/foundation.dart';

typedef double CalculatorInstructionCallback(double a, double b);

double _add(double a, double b) => a + b;
double _sub(double a, double b) => a - b;
double _mul(double a, double b) => a * b;
double _div(double a, double b) => a / b;
double _mod(double a, double b) => a % b;
double _not(double a, double b) => b == 1 ? 0 : 1;

enum CalculatorOpcode {
  add(_add, '+'),
  sub(_sub, '-'),
  mul(_mul, '✕'),
  div(_div, '÷'),
  mod(_mod, '%'),
  not(_not, '!');

  const CalculatorOpcode(this.exec, this.display);

  final CalculatorInstructionCallback exec;
  final String display;
}

enum CalculatorDataSource {
  register,
  constant,
}

class CalculatorData {
  const CalculatorData({
    required this.source,
    required this.constantValue,
  });

  final CalculatorDataSource source;
  final double constantValue;

  double resolve(double register) =>
    source == CalculatorDataSource.register ? register : constantValue;

  @override
  String toString() =>
    source == CalculatorDataSource.register ? 'x' : '$constantValue';
}

class CalculatorInstruction {
  const CalculatorInstruction({
    required this.opcode,
    this.dataLeft,
    this.dataRight,
    this.innerLeft = const <CalculatorInstruction>[],
    this.innerRight = const <CalculatorInstruction>[],
  });

  final CalculatorOpcode opcode;
  final CalculatorData? dataLeft;
  final CalculatorData? dataRight;
  final List<CalculatorInstruction> innerLeft;
  final List<CalculatorInstruction> innerRight;

  double execLeft(double register) {
    if (dataLeft == null) {
      for (final instr in innerLeft) {
        register = instr.exec(register);
      }
      return register;
    }
    return dataLeft!.resolve(register);
  }

  double execRight(double register) {
    if (dataRight == null) {
      for (final instr in innerRight) {
        register = instr.exec(register);
      }
      return register;
    }
    return dataRight!.resolve(register);
  }

  double exec(double register) =>
    opcode.exec(
      execLeft(register),
      execRight(register)
    );

  String printLeft() {
    if (dataLeft == null) {
      return '(${innerLeft.map((instr) => instr.toString()).join()})';
    }
    return dataLeft!.toString();
  }

  String printRight() {
    if (dataRight == null) {
      return '(${innerRight.map((instr) => instr.toString()).join()})';
    }
    return dataRight!.toString();
  }

  @override
  String toString() =>
    '${printLeft()} ${opcode.display} ${printRight()}';
}

class CalculatorMachine extends ChangeNotifier {
  CalculatorMachine();

  List<CalculatorInstruction> _prog = [];
  double? _result;

  void add(CalculatorInstruction instr) {
    _prog.add(instr);
    notifyListeners();
  }

  void remove() {
    _prog.removeLast();
    notifyListeners();
  }

  void reset() {
    _prog.clear();
    notifyListeners();
  }

  void exec() {
    double register = 0;
    for (final instr in _prog) {
      register = instr.exec(register);
    }
    _result = register;
    notifyListeners();
  }

  @override
  toString() {
    if (_result == null) {
      return _prog.map((instr) => instr.toString()).join();
    }
    return '$_result';
  }
}
