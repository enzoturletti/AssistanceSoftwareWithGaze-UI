
import 'package:flutter/material.dart';
import 'package:gaze_tracking/widgets/custom_grid.dart';
import 'package:mdi/mdi.dart';

import '../manager.dart';
import '../info.dart';
import 'empty.dart';

class CalibrationPage extends StatefulWidget {
  const CalibrationPage({Key? key}) : super(key: key);

  @override
  State<CalibrationPage> createState() => _CalibrationPageState();
}

class _CalibrationPageState extends State<CalibrationPage> {
  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      bodyWidget: CustomGrid(
        callableTime: Manager().callableTime,
        width: Manager().resolutionX.toDouble(),
        height: Manager().resolutionY.toDouble(),
        scaleIcons: 0.5,
        columns: 10,
        rows: 10,
        icons: getIcons(),
        functions: getFunctions(),
        textLabels: [],
        useText: false,
      ),
    );
  }

  void nullAction()
  {
  }

  void goToHome()
  {
    Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
  }

  List<VoidCallback> getFunctions()
  {
    List<VoidCallback> list = [];
    for(int i = 0; i < 99; i++)
    {
      list.add(nullAction);
    }

    list.add(goToHome);

    return list;
  }

  List<IconData> getIcons()
  {
    List<IconData> list = [];
    for(int i = 0; i < 99; i++)
    {
      list.add(Info.circle);
    }

    list.add(Mdi.locationExit);

    return list;
  }
}
