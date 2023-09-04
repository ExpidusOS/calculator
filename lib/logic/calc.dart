import 'dart:math';
import 'package:flutter/foundation.dart';

typedef double CalculatorInstructionCallback(double a, double b);

double _add(double a, double b) => a + b;
double _sub(double a, double b) => a - b;
double _mul(double a, double b) => a * b;
double _div(double a, double b) => a / b;
double _mod(double a, double b) => a % b;

double _not(double a, double b) {
  var fac = 1.0;

  for (var i = b; i >= 1.0; i--) {
    fac *= i;
  }

  return fac;
}

double _pow(double a, double b) => pow(a, b).toDouble();
double _sqrt(double a, double b) => sqrt(b);

double _left(double a, double b) => a;
double _right(double a, double b) => b;

enum CalculatorOpcode {
  add(_add, '+'),
  sub(_sub, '-'),
  mul(_mul, '✕'),
  div(_div, '÷'),
  mod(_mod, '%'),
  not(_not, '!', singleInput: true),
  pow(_pow, '^'),
  sqrt(_sqrt, '√', singleInput: true),
  left(_left, 'l'),
  right(_right, 'r');

  const CalculatorOpcode(this.exec, this.display, { this.singleInput = false });

  final CalculatorInstructionCallback exec;
  final String display;
  final bool singleInput;
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
    this.hasDecimal = false,
    this.opcode,
  });

  const CalculatorInstructionBuilderEntry.opcode(this.opcode)
    : kind = CalculatorInstructionBuilderEntryKind.opcode,
      constantValue = 0,
      hasDecimal = false;

  const CalculatorInstructionBuilderEntry.value(this.constantValue, {
    this.hasDecimal = false,
  })
    : kind = CalculatorInstructionBuilderEntryKind.value,
      opcode = null;

  const CalculatorInstructionBuilderEntry.special(this.kind)
    : constantValue = 0,
      opcode = null,
      hasDecimal = false;

  final CalculatorInstructionBuilderEntryKind kind;
  final double constantValue;
  final bool hasDecimal;
  final CalculatorOpcode? opcode;

  bool get isWhole => constantValue.remainder(constantValue.toInt()) == 0;
  int get decimalPlaces => isWhole && hasDecimal ? 0 : constantValue.toString().split('.')[1].length;

  @override
  String toString() {
    switch (kind) {
      case CalculatorInstructionBuilderEntryKind.opcode:
        return opcode!.display;
      case CalculatorInstructionBuilderEntryKind.value:
        return isWhole ? '${constantValue.toInt()}${hasDecimal ? "." : ""}' : '$constantValue';
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

class _CalculatorInstructionBuilderParens {
  const _CalculatorInstructionBuilderParens({
    required this.offset,
    required this.instr,
  });

  final int offset;
  final CalculatorInstruction instr;
}

class CalculatorInstructionBuilder {
  CalculatorInstructionBuilder();

  List<CalculatorInstructionBuilderEntry> _entries = [];

  bool get canCloseParens {
    for (var i = 0; i < _entries.length; i++) {
      final entry = _entries[i];
      if (entry.kind == CalculatorInstructionBuilderEntryKind.openParens && i + 1 < _entries.length) return true;
    }
    return false;
  }

  void add(CalculatorInstructionBuilderEntry entry) {
    if (_entries.isEmpty && (entry.kind == CalculatorInstructionBuilderEntryKind.closedParens || entry.kind == CalculatorInstructionBuilderEntryKind.opcode || entry.kind == CalculatorInstructionBuilderEntryKind.closedParens)) {
      if (entry.kind == CalculatorInstructionBuilderEntry.opcode && !entry.opcode!.singleInput) {
        return;
      }
    }

    if (_entries.isNotEmpty) {
      if (_entries.last.kind == entry.kind && entry.kind == CalculatorInstructionBuilderEntryKind.value) {
        if (_entries.last.hasDecimal) {
          // TODO: This is dumb and should NEVER be done again, we should be shifting decimal places but trying to type 55.55 we got 55.75.
          // The code was "_entries.last.constantValue + (entry.constantValue / ((_entries.last.decimalPlaces + 1) * 10))"
          _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value(
            double.parse((_entries.last.decimalPlaces == 0 ? '${_entries.last.constantValue.toInt()}.' : _entries.last.constantValue.toString()) + entry.constantValue.toInt().toString()),
            hasDecimal: true
          );
        } else {
          _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value((_entries.last.constantValue * 10) + entry.constantValue);
        }
        return;
      } else if (_entries.last.kind == CalculatorInstructionBuilderEntryKind.value && entry.kind == CalculatorInstructionBuilderEntryKind.decimal) {
        _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value(
          _entries.last.constantValue,
          hasDecimal: true
        );
        return;
      } else if (_entries.last.kind == CalculatorInstructionBuilderEntryKind.opcode && entry.kind == CalculatorInstructionBuilderEntryKind.opcode) {
        return;
      }
    }

    _entries.add(entry);
  }

  void remove() {
    if (_entries.isNotEmpty) {
      if (_entries.last.kind == CalculatorInstructionBuilderEntryKind.value && _entries.last.constantValue >= 10) {
        if (_entries.last.isWhole && !_entries.last.hasDecimal) {
          _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value(
            (_entries.last.constantValue / 10).toInt() * 1.0,
            hasDecimal: _entries.last.hasDecimal
          );
        } else if (_entries.last.isWhole && _entries.last.hasDecimal) {
          _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value(
            _entries.last.constantValue,
            hasDecimal: false
          );
        } else if (!_entries.last.isWhole && _entries.last.hasDecimal) {
          // TODO: Another very... very.. dumb way of removing decimals off a number.
          // This shouldn't be done this way because of performance but for simplicities sake, it is done dumb.
          final l = _entries.last.constantValue.toString().split('.');
          _entries[_entries.length - 1] = CalculatorInstructionBuilderEntry.value(
            double.parse('${l[0]}.${l[1].substring(0, l[1].length - 1)}'),
            hasDecimal: true
          );
        }
        return;
      }

      _entries.removeLast();
    }
  }

  void clear() {
    _entries.clear();
  }

  CalculatorData _entry2data(CalculatorInstructionBuilderEntry entry) {
    if (entry.kind == CalculatorInstructionBuilderEntryKind.pi) {
      return const CalculatorData(
        source: CalculatorDataSource.constant,
        constantValue: pi,
      );
    }
    return CalculatorData(
      source: CalculatorDataSource.constant,
      constantValue: entry.constantValue,
    );
  }

  CalculatorData _fetch(int i) {
    if (i < 0 || i >= _entries.length) {
      return const CalculatorData(
        source: CalculatorDataSource.constant,
        constantValue: 0,
      );
    }

    return _entry2data(_entries[i]);
  }

  _CalculatorInstructionBuilderParens _commit(int offset, int length) {
    // FIXME: Figure out how to actually do parenstheses.
    CalculatorData? dataLeft = null;
    CalculatorData? dataRight = null;
    List<CalculatorInstruction> innerLeft = [];
    List<CalculatorInstruction> innerRight = [];

    final opcode = offset == 0 ? CalculatorOpcode.left : _entries[offset].opcode!;

    for (; offset < length; offset++) {
      if (_entries[offset].kind != CalculatorInstructionBuilderEntryKind.opcode) continue;

      innerLeft.add(CalculatorInstruction(
        opcode: _entries[offset].opcode!,
        dataLeft: _fetch(offset - 1),
        dataRight: _fetch(offset + 1),
      ));
    }

    return _CalculatorInstructionBuilderParens(
      offset: offset,
      instr: CalculatorInstruction(
        opcode: opcode,
        dataLeft: dataLeft,
        dataRight: dataRight,
        innerLeft: innerLeft,
        innerRight: innerRight,
      ),
    );
  }

  void commit(CalculatorMachine machine) {
    // TODO: most of the time, operations will be a multiple of 3 but that won't always be the case.
    // Need to determine how to figure out if the number of entries is valid for an operation.
    final canCommit = _entries.length > 1;
    if (!canCommit) return;

    machine.add(_commit(0, _entries.length).instr);
  }

  @override
  String toString() => _entries.map((entry) => entry.toString()).join();
}

class CalculatorMachine extends ChangeNotifier {
  CalculatorMachine();

  List<CalculatorInstruction> _prog = [];
  double? _result;

  double get result => _result ?? 0;

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
