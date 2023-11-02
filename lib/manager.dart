import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaze_tracking/utils/response_object.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';
import 'package:ini/ini.dart';
import 'package:flutter/services.dart';

enum States {
  INIT,
  MOUSE
}

class Manager {

  static final Manager _singleton = Manager._internal();
  factory Manager() {

    return _singleton;
  }
  Manager._internal();

  late bool flutterDebug;

  late WebSocketChannel channel;
  late StreamController streamController;
  late IconData requiredActionIcon;
  late States state;
  late int callableTime;
  late int resolutionX;
  late int resolutionY;
  late int aspectRatioHorizontal;
  late int aspectRatioVertical;
  late double diagonalSize;
  late double offsetCamera;

  void connectServer()
  {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:2223'),);
    streamController = StreamController.broadcast();
    streamController.addStream(channel.stream);
    channel.sink.add("Init");
  }

  Future<void> loadSettings()
  async {
    state = States.INIT;

    const String pathConfigIni = "assets/config.ini"; //path to text file asset
    final String contents = await rootBundle.loadString(pathConfigIni);
    final config = Config.fromString(contents);

    flutterDebug = (1 == int.parse(config.get("flutter","flutter_debug").toString()));
    callableTime = int.parse(config.get("flutter","callable_time").toString());
    resolutionX = int.parse(config.get("screen_size","resolution_x").toString());
    resolutionY = int.parse(config.get("screen_size","resolution_y").toString());
    aspectRatioHorizontal = int.parse(config.get("screen_size","aspect_ratio_horizontal").toString());
    aspectRatioVertical = int.parse(config.get("screen_size","aspect_ratio_vertical").toString());
    diagonalSize = double.parse(config.get("screen_size","diagonal_size").toString());
    offsetCamera = double.parse(config.get("screen_size","offset_camera").toString());

    state = States.MOUSE;
  }

  bool isInitializing()
  {
    return state == States.INIT;
  }
  
  void setMouseState()
  {
    state = States.MOUSE;
  }

  Stream<dynamic> getStream()
  {
    return streamController.stream;
  }

  IconData getRequiredActionIcon()
  {
    return requiredActionIcon;
  }

  void setRequiredActionIcon(IconData requiredActionIcon)
  {
    this.requiredActionIcon = requiredActionIcon;
  }

}