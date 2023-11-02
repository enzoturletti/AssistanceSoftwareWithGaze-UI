import 'package:flutter/cupertino.dart';
import 'package:gaze_tracking/manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mdi/mdi.dart';

import '../info.dart';
import '../widgets/custom_grid.dart';
import 'empty.dart';

class RequiredExternalActionPage extends StatefulWidget {
  final player = AudioPlayer();
  bool playing = false;

  RequiredExternalActionPage({Key? key}) : super(key: key);

  @override
  State<RequiredExternalActionPage> createState() => _RequiredExternalActionPageState();
}

class _RequiredExternalActionPageState extends State<RequiredExternalActionPage> {
  @override
  Widget build(BuildContext context) {

    if(widget.playing == false)
    {
      playAudio();
    }

    return EmptyPage(
      bodyWidget: CustomGrid(
        callableTime: Manager().callableTime,
        width: Manager().resolutionX.toDouble(),
        height: Manager().resolutionY.toDouble(),
        scaleIcons: 0.5,
        columns: 2,
        rows: 1,
        icons: getIconData(),
        useText: false,
        textLabels: [],
        functions:
        [
          nullAction,
          goHome,
        ],
      ),
    );
  }

  void nullAction()
  {
  }

  void goHome()
  {
    widget.playing = false;
    widget.player.stop();
    Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
  }

  List<IconData> getIconData()
  {
    List<IconData> icons = [
      Manager().getRequiredActionIcon(),
      Mdi.locationExit
    ];

    return icons;
  }

  Future<void> playAudio()
  async
  {
    await widget.player.setAsset('assets/audio/alarm.wav');
    widget.player.setLoopMode(LoopMode.all);
    widget.playing = true;
    await widget.player.play();
  }

  
}
