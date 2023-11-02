import 'package:flutter/material.dart';
import 'package:gaze_tracking/pages/empty.dart';
import 'package:gaze_tracking/info.dart';

import '../manager.dart';
import '../widgets/custom_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      bodyWidget: CustomGrid(
        callableTime: Manager().callableTime,
        width: Manager().resolutionX.toDouble(),
        height: Manager().resolutionY.toDouble(),
        scaleIcons: 0.5,
        columns: 2,
        rows: 2,
        icons: Info.gridHomeIcons,
        useText: false,
        textLabels: const [],
        functions: [
          goToKeyboardPage,
          goToSettingsPage,
          goToShortcutsPage,
          goToCalibrationPage
        ],
      ),
    );
  }

  void goToKeyboardPage() {
    Navigator.of(context).pushNamedAndRemoveUntil('/Keyboard', (Route<dynamic> route) => false);
  }

  void goToSettingsPage() {
    Navigator.of(context).pushNamedAndRemoveUntil('/Settings', (Route<dynamic> route) => false);
  }

  void goToShortcutsPage() {
    Navigator.of(context).pushNamedAndRemoveUntil('/Shortcuts', (Route<dynamic> route) => false);
  }

  void goToCalibrationPage() {
    Navigator.of(context).pushNamedAndRemoveUntil('/Calibration', (Route<dynamic> route) => false);
  }
}
