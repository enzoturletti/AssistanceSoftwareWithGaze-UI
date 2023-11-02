import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:gaze_tracking/info.dart';

import '../manager.dart';

class EmptyPage extends StatefulWidget {
  Widget bodyWidget;

  EmptyPage({Key? key, required this.bodyWidget}) : super(key: key);

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  bool isFullscreen = false;
  bool listenerCreated = false;

  void _updateUI(bool isFullscreen) {
    setState(() {
      this.isFullscreen = isFullscreen;
    });
  }

  void _goFullScreen() {
    html.document.documentElement?.requestFullscreen();
  }

  void _exitFullScreen() {
    html.document.exitFullscreen();
  }

  void _onFullScreenChange(html.Event event) {
    bool result;
    if (html.document.fullscreenElement != null) {
      result = true;
    } else {
      result = false;
    }

    _updateUI(result);
  }

  @override
  Widget build(BuildContext context) {
    if (listenerCreated == false) {
      html.document.addEventListener('fullscreenchange', _onFullScreenChange);
      listenerCreated = true;
    }

    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Center(
            child: SizedBox(
                width: Manager().resolutionX.toDouble(),
                height: Manager().resolutionY.toDouble(),
                child: widget.bodyWidget),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: isFullscreen ? _exitFullScreen : _goFullScreen,
        tooltip: 'fullscreen',
        child: isFullscreen
            ? const Icon(IconData(0xe16b, fontFamily: 'MaterialIcons'))
            : const Icon(IconData(0xe2cb, fontFamily: 'MaterialIcons')),
      ),
    );
  }
}
