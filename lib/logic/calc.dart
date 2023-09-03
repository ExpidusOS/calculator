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

enum CalculatorInstructionBuilderEntryKind {
  opcode,
  value,
  decimal,
  openParens,
  closedParens,
  pi
}

class CalculatorInstructionBuilderEntry {
  const CalculatorInstructionBuilderEntry({
    required this.kind,
    this.constantValue = 0,
    this.opcode,
  });

  const CalculatorInstructionBuilderEntry.opcode(this.opcode)
    : kind = CalculatorInstructionBuilderEntryKind.opcode,
      constantValue = 0;

  const CalculatorInstructionBuilderEntry.value(this.constantValue)
    : kind = CalculatorInstructionBuilderEntryKind.value,
      opcode = null;

  final CalculatorInstructionBuilderEntryKind kind;
  final int constantValue;
  final CalculatorOpcode? opcode;

  @override
  String toString() {
    switch (kind) {
      case CalculatorInstructionBuilderEntryKind.opcode:
        return opcode!.display;
      case CalculatorInstructionBuilderEntryKind.value:
        return '$constantValue';
      case CalculatorInstructionBuilderEntryKind.decimal:
        return '.';
      case CalculatorInstructionBuilderEntryKind.openParens:
        return '(';
      case CalculatorInstructionBuilderEntryKind.closedParens:
        return ')';
      case CalculatorInstructionBuilderEntryKind.pi:
        return '𐍀';
    }
  }
}

class CalculatorInstructionBuilder {
  CalculatorInstructionBuilder();

  List<CalculatorInstructionBuilderEntry> _entries = [];

  void add(CalculatorInstructionBuilderEntry entry) {
    if (_entries.isNotEmpty) {
      if (_entries.last.kind == entry.kind && entry.kind == CalculatorInstructionBuilderEntryKind.value) {
        _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value((_entries.last.constantValue * 10) + entry.constantValue);
        return;
      }
    }

    _entries.add(entry);
  }

  void remove() {
    if (_entries.isNotEmpty) {
      if (_entries.last.kind == CalculatorInstructionBuilderEntryKind.value && _entries.last.constantValue >= 10) {
        _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value((_entries.last.constantValue / 10).toInt());
        return;
      }

      _entries.removeLast();
    }
  }

  void clear() {
    _entries.clear();
  }

  @override
  String toString() => _entries.map((entry) => entry.toString()).join();
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
    _result = null;
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
