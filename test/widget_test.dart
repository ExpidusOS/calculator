// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:calculator/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pubspec/pubspec.dart';

void main() {
  testWidgets('Calculator input', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp(
      pubspec: PubSpec.fromYamlString(await rootBundle.loadString('pubspec.yaml')),
    ));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.pump();

    expect(find.text('123'), findsNothing);
  });
}
