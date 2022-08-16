import 'package:anim/common/brushes.dart';
import 'package:flutter/material.dart';

class CircleOkPainter extends CustomPainter {
  final color;
  final isFilled;
  final wasFilled;
  final double animRadius;
  final double animRadiusOk;
  final double animLongLineOkDx;
  final double animShortLineOkDxB;
  final double animShortLineOkDyB;
  final double animLongLineOkDxB;
  final double animLongLineOkDyB;
  final double animShortLineOkDx;
  final double animShortLineOkDy;
  final double animLongLineOkDy;
  final Offset center;

  CircleOkPainter({required this.animLongLineOkDx ,
    required this.center,
    required this.animRadiusOk,
    required this.color,
    required this.isFilled,
    required this.animRadius,
    required this.wasFilled,
    required this.animLongLineOkDy,
    required this.animShortLineOkDy,
    required this.animShortLineOkDx,
    required this.animLongLineOkDxB,
    required this.animShortLineOkDyB,
    required this.animShortLineOkDxB,
    required this.animLongLineOkDyB,
  });


  @override
  void paint(Canvas canvas, Size size) {
    var outLineBrush = Paint()..color = color;

    canvas.drawCircle(center, 25, outLineBrush);


    if(wasFilled && !isFilled) {
      canvas.drawCircle(center, (animRadius - 20).abs(), AppBrushes.fillBrush);
      canvas.drawLine(Offset(25, 30), Offset(animShortLineOkDxB,animShortLineOkDyB ), AppBrushes.okLineBrush);
      canvas.drawLine(Offset(25, 30), Offset(animLongLineOkDxB, animLongLineOkDyB), AppBrushes.okLineBrush);
      canvas.drawCircle(Offset(25, 30), (animRadiusOk - 2).abs(), AppBrushes.fillBrush);
    }

    if (!isFilled && !wasFilled) {
      canvas.drawCircle(center, 20, AppBrushes.fillBrush);
    }

    if (isFilled) {
      canvas.drawCircle(center, animRadius, AppBrushes.fillBrush);
      canvas.drawLine(Offset(25, 30), Offset(animShortLineOkDx , animShortLineOkDy), AppBrushes.okLineBrush);
      canvas.drawLine(Offset(25, 30), Offset(animLongLineOkDx, animLongLineOkDy), AppBrushes.okLineBrush);
      // print(animLongLineOkDx);
      canvas.drawCircle(Offset(25, 30), animRadiusOk, AppBrushes.fillBrush);
    }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}