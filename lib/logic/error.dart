import 'package:calculator/logic.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool reportFlutterError(Object e, { StackTrace? trace }) {
  trace ??= StackTrace.current;

  FlutterError.reportError(FlutterErrorDetails(
    exception: e,
    stack: trace,
  ));
  return true;
}

Future<bool> isSentryEnabled() async {
  try {
    const sentryDsn = String.fromEnvironment('SENTRY_DSN', defaultValue: '');
    final prefs = await SharedPreferences.getInstance();

    return sentryDsn.isNotEmpty
      && (prefs.getBool(CalculatorSettings.optInErrorReporting.name) ?? false);
  } catch (error, trace) {
    reportFlutterError(error, trace: trace);
    return false;
  }
}

Future<bool> reportSentryError(Object e, { StackTrace? trace }) async {
  if (await isSentryEnabled()) {
    return true;
  }
  return false;
}

Future<void> reportError(Object e, { StackTrace? trace }) async {
  if (await reportSentryError(e, trace: trace)) {
    return;
  }

  reportFlutterError(e, trace: trace);
}