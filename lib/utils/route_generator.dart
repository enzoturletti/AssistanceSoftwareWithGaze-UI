
import 'package:flutter/material.dart';
import 'package:gaze_tracking/pages/calibration.dart';
import 'package:gaze_tracking/pages/home.dart';
import 'package:gaze_tracking/pages/partial_keyboard.dart';
import 'package:gaze_tracking/pages/requiredexternalaction.dart';
import 'package:gaze_tracking/pages/settings.dart';
import 'package:gaze_tracking/pages/shortcuts.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/Home':
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case '/Keyboard':
        return MaterialPageRoute(builder: (_) => const PartialKeyboardPage());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/Shortcuts':
        return MaterialPageRoute(builder: (_) => const ShortcutsPage());
      case '/Calibration':
        return MaterialPageRoute(builder: (_) => const CalibrationPage());
      case '/RequiredAction':
        return MaterialPageRoute(builder: (_) => RequiredExternalActionPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}