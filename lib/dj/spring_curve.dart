import 'package:flutter/material.dart';

class SpringCurve extends Curve {

  SpringCurve({this.tension = 1.0});

  double tension;

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((tension + 1) * t + tension) + 1.0;
  }
}