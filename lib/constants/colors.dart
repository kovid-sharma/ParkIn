import 'package:flutter/material.dart';

import 'dart:math' as math;
Color backColor = const Color(0xff000000);
Color backLightColor = const Color(0xFFFAFAF4);
Color white = const Color(0xffffffff);
Color gray = Colors.black45;
Color green= Colors.green;
Color redColor=  const Color(0xffef340a);
Color redLightColor=  const Color(0xffe73207);


LinearGradient buttonGradient = const LinearGradient(
  begin: Alignment(-0.8, 1.4),
  end: Alignment(0.8, -1.4),
  colors: [
    Colors.redAccent,
    Color(0xffec5634),
    Colors.redAccent,
    Color(0xffec5634),
  ],
  stops: [-0.082, 0.4, 0.6848, 0.9257],
  transform: GradientRotation(
    7843 * (math.pi / 10000),
  ),
);