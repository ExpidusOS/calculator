import 'package:shared_preferences/shared_preferences.dart';

enum CalculatorSettings<T> {
  optInErrorReporting(false);

  const CalculatorSettings(this.defaultValue);

  final T defaultValue;
  T valueFor(SharedPreferences prefs) =>
      (prefs.get(name) as T?) ?? defaultValue;
  Future<T> get value async => valueFor(await SharedPreferences.getInstance());

  @override
  toString() => '$name:${T.toString()}';
}
