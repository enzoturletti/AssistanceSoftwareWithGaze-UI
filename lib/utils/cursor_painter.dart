import 'dart:ui';
import 'package:flutter/material.dart';

class CursorPainter extends CustomPainter
{
  List<Offset> points = [];

  CursorPainter(double px, double py) : super()
  {
    saveCursorPoint(px,py);
  }

  @override
  void paint(Canvas canvas, Size size) 
  {
    drawCursorPoint(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawCursorPoint(Canvas canvas)
  {
    var paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 15;
    canvas.drawPoints(PointMode.points, points, paint);
  }

  void saveCursorPoint(double px, double py)
  {
    points = [Offset(px,py)];
  }

}