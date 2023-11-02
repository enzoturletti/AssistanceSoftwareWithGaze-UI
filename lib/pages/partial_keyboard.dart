import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaze_tracking/widgets/custom_grid.dart';
import '../manager.dart';
import '../info.dart';
import 'empty.dart';

class PartialKeyboardPage extends StatefulWidget {
  const PartialKeyboardPage({Key? key}) : super(key: key);

  @override
  State<PartialKeyboardPage> createState() => _PartialKeyboardPageState();
}

class _PartialKeyboardPageState extends State<PartialKeyboardPage> {
  int index = 0;
  var txt = TextEditingController();
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      bodyWidget: Column(
        children: [
          Flexible(
            child: CustomGrid(
              callableTime: Manager().callableTime,
              width: Manager().resolutionX.toDouble(),
              height: Manager().resolutionY.toDouble(),
              scaleIcons: 0.5,
              columns: 5,
              rows: 3,
              icons: getIcons(index),
              textLabels: [],
              useText: false,
              functions: getFunctions(),
            ),
          ),
          Container(
            color: Colors.transparent,
            width: Manager().resolutionX.toDouble(),
            height: 0,
            child: Center(
              child: TextField(
                controller: txt,
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<IconData> getIcons(int index) {
    List<IconData> icons =
        List.generate(15, (i) => Info.gridPartialKeyboardIcons[0]);

    icons[10] = Info.gridPartialKeyboardIcons[27]; // delete one letter.
    icons[0] = Info.gridPartialKeyboardIcons[28]; // delete all letter.
    icons[14] = Info.gridPartialKeyboardIcons[29]; // go Home
    icons[5] = Info.gridPartialKeyboardIcons[30]; // left arrow
    icons[9] = Info.gridPartialKeyboardIcons[31]; // right arrow
    icons[4] = Info.gridPartialKeyboardIcons[32]; // null icon

    List<int> lettersContainerIndex = [1, 2, 3, 6, 7, 8, 11, 12, 13];

    int lettersIconAdded = 0;
    int internalIndex = 0;

    for (int i in lettersContainerIndex) {
      if (index == 2 && (i == 12 || i == 13)) {
        icons[i] = Info.gridPartialKeyboardIcons[32];
      } else {
        icons[i] = Info.gridPartialKeyboardIcons[internalIndex + index * 3];
        internalIndex++;
        lettersIconAdded++;
        if (lettersIconAdded % 3 == 0) {
          internalIndex = internalIndex + 7;
        }
      }
    }

    if (index == 2) {
      icons[4] = Info.gridPartialKeyboardIcons[9];
      icons[12] = Info.gridPartialKeyboardIcons[33];
    }

    return icons;
  }

  List<VoidCallback> getFunctions() {
    List<VoidCallback> list = List.generate(15, (i) => nullAction);

    list[10] = deleteLastLetterMsg; // delete one letter.
    list[0] = deleteAllMsg; // delete all letter.
    list[14] = goHome; // go Home
    list[5] = leftArrow; // left arrow
    list[9] = rightArrow; // right arrow
    list[4] = nullAction; // null icon

    List<int> lettersContainerIndex = [1, 2, 3, 6, 7, 8, 11, 12, 13];
    int lettersIconAdded = 0;
    int internalIndex = 0;

    for (int i in lettersContainerIndex) {
      if (index == 2 && (i == 12 || i == 13)) {
        list[i] = nullAction;
      } else {
        list[i] = functionGenerator(internalIndex + index * 3);
        internalIndex++;
        lettersIconAdded++;
        if (lettersIconAdded % 3 == 0) {
          internalIndex = internalIndex + 7;
        }
      }
    }

    if (index == 2) {
      list[4] = functionGenerator(9);
      list[12] = spaceAction;
    }

    return list;
  }

  VoidCallback functionGenerator(int keyboardIndex) {
    List<String> letters = [
      "Q",
      "W",
      "E",
      "R",
      "T",
      "Y",
      "U",
      "I",
      "O",
      "P",
      "A",
      "S",
      "D",
      "F",
      "G",
      "H",
      "J",
      "K",
      "L",
      "Ñ",
      "Z",
      "X",
      "C",
      "V",
      "B",
      "N",
      "M"
    ];
    void pressLetter() {
      setState(() {
        msg = msg + letters[keyboardIndex];
        txt.text = msg;
      });
    }

    return pressLetter;
  }

  void spaceAction()
  {
    setState(() {
      msg = "$msg " ;
      txt.text = msg;
    });
  }

  void nullAction() {
  }

  void deleteLastLetterMsg() {
    setState(() {
      if (msg != null && msg.length > 0) {
        msg = msg.substring(0, msg.length - 1);
      }
      txt.text = msg;
    });
  }

  void deleteAllMsg() {
    setState(() {
      msg = "";
      txt.text = msg;
    });
  }

  void leftArrow() {
    if (index == 0) {
      setState(() {
        index = 2;
      });
    } else {
      setState(() {
        index -= 1;
      });
    }
  }

  void rightArrow() {
    if (index == 2) {
      setState(() {
        index = 0;
      });
    } else {
      setState(() {
        index += 1;
      });
    }
  }

  void goHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
  }
}
