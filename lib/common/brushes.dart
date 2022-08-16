import 'package:flutter/material.dart';

class AppBrushes {
  static var fillBrush = Paint()..color = Colors.white;

  static var okLineBrush = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;
}