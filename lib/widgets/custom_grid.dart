import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../manager.dart';
import 'dart:async';

class CustomGrid extends StatefulWidget {
  double width;
  double height;
  double scaleIcons;
  int rows;
  int columns;
  int callableTime;
  final List<IconData> icons;
  final List<VoidCallback> functions;
  late double lookingPX;
  late double lookingPY;
  bool eyeOpen = false;
  late bool useText;
  late List<String> textLabels;
  List<int> eyeOpenBuffer =  List<int>.filled(7, 1, growable: true);

  Timer clickableTimer = Timer(const Duration(seconds: 1), () {});
  Function selectedFunction = () {};
  Function callableFunction = () {};
  bool callableStatus = false;

  CustomGrid(
      {Key? key,
      required this.callableTime,
      required this.functions,
      required this.width,
      required this.height,
      required this.rows,
      required this.columns,
      required this.icons,
      required this.textLabels,
      required this.useText,
      required this.scaleIcons})
      : super(key: key);

  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  late var itemsInits;
  late bool itemSelectedFound;

  @override
  Widget build(BuildContext context) {
    createItemsInits();

    if (Manager().flutterDebug) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: createItems(),
        ),
      );
    }

    return StreamBuilder<dynamic>(
      stream: Manager().getStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading popup when waiting for data
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // Show error message if there's an error
          return const Text(
            "Connect to server",
            style: TextStyle(color: Colors.white),
          );
        }
        if (snapshot.hasData) {
          Map<String, dynamic> map = jsonDecode(snapshot.data);

          if (Manager().isInitializing()) {
            bool success = map["result"];

            if (success) {
              Manager().setMouseState();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          widget.lookingPX = map["px"];
          widget.lookingPY = map["py"];
          widget.eyeOpen = map["eye_open"];

          if(widget.callableStatus)
          {
            updateEyeOpenBuffer();
          }

          if(checkClick() && widget.callableStatus)
          {
            Future.microtask(() {
              resetEyeOpenBuffer();
              widget.selectedFunction = (){};
              widget.callableStatus = false;
              widget.callableFunction.call();
            });
          }

          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: Stack(
              children: createItems(),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void createItemsInits() {
    double itemWidth = widget.width / widget.columns;
    double itemHeight = widget.height / widget.rows;

    itemsInits = [];
    itemsInits = List.generate(
        widget.rows,
        (i) => List.generate(
            widget.columns, (j) => [j * itemWidth, i * itemHeight]),
        growable: false);
  }

  Widget createItem(int i) {
    int itemRowIndex = 0;
    int itemColumnIndex = 0;
    for (int j = 0; j < i; j++) {
      itemColumnIndex++;
      if (itemColumnIndex == widget.columns) {
        itemColumnIndex = 0;
        itemRowIndex++;
      }
    }

    bool itemSelected;
    if (!itemSelectedFound) {
      itemSelected = isItemSelected(itemRowIndex, itemColumnIndex);

      if (itemSelected) {
        Function newSelectedFunction = widget
            .functions[getIndexFromRowAndColumn(itemRowIndex, itemColumnIndex)];

        if (widget.selectedFunction != newSelectedFunction) {
          widget.selectedFunction = newSelectedFunction;
          widget.callableStatus = false;
          resetEyeOpenBuffer();
          if (widget.clickableTimer.isActive) {
            widget.clickableTimer.cancel();
          }
          widget.clickableTimer =
              Timer(Duration(seconds: widget.callableTime), doCallableFunction);
        }

        itemSelectedFound = true;
      }
    } else {
      itemSelected = false;
    }

    late Color color_;
    if (itemSelected && !widget.callableStatus) {
      color_ = Colors.green;
    } else if (itemSelected && widget.callableStatus) {
      color_ = Colors.yellow;
    } else {
      color_ = Colors.black;
    }

    Widget item = Positioned(
      left: itemsInits[itemRowIndex][itemColumnIndex][0],
      top: itemsInits[itemRowIndex][itemColumnIndex][1],
      child: GestureDetector(
        onTap: widget.functions[i],
        child: Container(
          width: widget.width / widget.columns,
          height: widget.height / widget.rows,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: color_)),
          child: !widget.useText
              ? Icon(
                  widget.icons[i],
                  size: widget.scaleIcons * widget.height / widget.rows,
                  color: color_,
                )
              : Center(
                  child: Text(
                    widget.textLabels[i],
                    style: TextStyle(
                        fontSize: 25,
                        color: color_,
                        fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ),
    );

    return item;
  }

  bool isItemSelected(int itemRowIndex, int itemColumnIndex) {
    if (Manager().flutterDebug) {
      return false;
    }

    double x = widget.lookingPX;
    double y = widget.lookingPY;

    int gridWidth = widget.width ~/ widget.columns;
    int gridHeight = widget.height ~/ widget.rows;

    x = max(0, min(x, widget.width - 1));
    y = max(0, min(y, widget.height - 1));

    int gridX = x ~/ gridWidth;
    int gridY = y ~/ gridHeight;

    if (gridX == itemColumnIndex && gridY == itemRowIndex) {
      return true;
    }

    return false;
  }

  List<Widget> createItems() {
    itemSelectedFound = false;

    List<Widget> items = [];
    for (int i = 0; i < widget.columns * widget.rows; i++) {
      items.add(createItem(i));
    }

    return items;
  }

  void doCallableFunction() {
    widget.callableFunction = widget.selectedFunction;
    widget.callableStatus = true;
  }

  int getIndexFromRowAndColumn(int rowIndex, int columnIndex) {
    int index = rowIndex * widget.columns + columnIndex;
    return index;
  }

  void updateEyeOpenBuffer() {
    widget.eyeOpenBuffer.removeAt(0);

    if (widget.eyeOpen) {
      widget.eyeOpenBuffer.add(1);
    } else {
      widget.eyeOpenBuffer.add(0);
    }
  }

  void resetEyeOpenBuffer()
  {
    for(int i = 0; i < widget.eyeOpenBuffer.length;i++)
    {
      widget.eyeOpenBuffer[i] = 1;
    }
  }

  bool checkClick() {
    double mean = 0;

    if(widget.eyeOpenBuffer.isEmpty)
    {
      return false;
    }

    for (int i = 0; i < widget.eyeOpenBuffer.length; i++)
    {
      mean += widget.eyeOpenBuffer[i].toDouble();
    }
    mean = mean / widget.eyeOpenBuffer.length;

    if (mean < 0.3) {
      return true;
    } else {
      return false;
    }
  }
}
