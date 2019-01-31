import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class CircleClipper extends CustomClipper<Rect> {
  CircleClipper({@required this.bottomOffsetY, this.progress = 0.0});

  double bottomOffsetY;
  double progress;

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height - bottomOffsetY),
      radius: sqrt(pow(size.width, 2) + pow(size.height, 2)) * progress
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }


}