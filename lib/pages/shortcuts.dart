import 'package:flutter/material.dart';
import '../manager.dart';
import '../info.dart';
import '../widgets/custom_grid.dart';
import 'empty.dart';

class ShortcutsPage extends StatefulWidget {
  const ShortcutsPage({Key? key}) : super(key: key);

  @override
  State<ShortcutsPage> createState() => _ShortcutsPageState();
}

class _ShortcutsPageState extends State<ShortcutsPage> {
  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      bodyWidget: CustomGrid(
        callableTime: Manager().callableTime,
        width: Manager().resolutionX.toDouble(),
        height: Manager().resolutionY.toDouble(),
        scaleIcons: 0.5,
        columns: 3,
        rows: 3,
        icons: Info.gridShortcutIcons,
        useText: false,
        textLabels: [],
        functions: [
          goRequiredActionPageWithAction0,
          goRequiredActionPageWithAction1,
          goRequiredActionPageWithAction2,
          goRequiredActionPageWithAction3,
          goRequiredActionPageWithAction4,
          goHome,
          goRequiredActionPageWithAction5,
          goRequiredActionPageWithAction6,
          goRequiredActionPageWithAction7
        ],
      ),
    );
  }

  void goHome() {
    Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
  }
  void noActionFunction()
  {
  }

  void goRequiredActionPageWithAction0()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[0]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

  void goRequiredActionPageWithAction1()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[1]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

  void goRequiredActionPageWithAction2()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[2]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

  void goRequiredActionPageWithAction3()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[3]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

  void goRequiredActionPageWithAction4()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[4]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

  void goRequiredActionPageWithAction5()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[6]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

  void goRequiredActionPageWithAction6()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[7]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

  void goRequiredActionPageWithAction7()
  {
    Manager().setRequiredActionIcon(Info.gridShortcutIcons[8]);
    Navigator.of(context).pushNamedAndRemoveUntil('/RequiredAction', (Route<dynamic> route) => false);
  }

}
