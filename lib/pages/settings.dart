import 'package:flutter/material.dart';
import 'package:gaze_tracking/manager.dart';
import 'package:gaze_tracking/pages/empty.dart';
import 'package:mdi/mdi.dart';

import '../info.dart';
import '../widgets/custom_grid.dart';

class SettingsPage extends StatefulWidget
{
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
  bool resetSettings = true;

}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    List<VoidCallback> listFunctions = [
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      nullAction,
      goHome
    ];

    return EmptyPage(
      bodyWidget: Flexible(
        child: CustomGrid(
          callableTime: Manager().callableTime,
          width: Manager().resolutionX.toDouble(),
          height: Manager().resolutionY.toDouble(),
          scaleIcons: 0.5,
          columns: 3,
          rows: 4,
          icons: [],
          useText: true,
          textLabels: getTextLabels(),
          functions: listFunctions,
        ),
      ),
    );
  }

  List<String> getTextLabels()
  {
    List<String> list = [];

    list.add("RESOLUTION");
    list.add("${Manager().resolutionX} x ${Manager().resolutionY}");
    list.add("");
    list.add("ASPECT RATIO");
    list.add("${Manager().aspectRatioHorizontal} : ${Manager().aspectRatioVertical}");
    list.add("");
    list.add("CAMERA OFFSET");
    list.add("${Manager().offsetCamera} mm");
    list.add("");
    list.add("");
    list.add("");
    list.add("HOME");

    return list;
  }

  void goHome()
  {
    Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
  }

  void nullAction() {}
}
