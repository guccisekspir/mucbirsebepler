import 'dart:math';

import 'package:flutter/material.dart';

LinearGradient randomGradient() {
  return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors:
          gradientColorsList[Random().nextInt(gradientColorsList.length - 1)]);
}

List<List<Color>> gradientColorsList = [
  [Color(0xFF00C9FF), Color(0xff92FE9D)],
  [Color(0xFFFFB75E), Color(0xffED8F03)],
  [Color(0xFFB24592), Color(0xffF15F79)],
  [Color(0xFF0cebeb), Color(0xff29ffc6)],
  [Color(0xFF78ffd6), Color(0xff007991)],
  [Color(0xFF4568DC), Color(0xffB06AB3)],
  [Color(0xFFee0979), Color(0xffff6a00)],
  [Color(0xFFfc00ff), Color(0xff00dbde)],
  [Color(0xFF833ab4), Color(0xfffd1d1d),Color(0xfffcb045)],
  [Color(0xFFfdfc47), Color(0xff24fe41)],
  [Color(0xFF12c2e9), Color(0xffc471ed), Color(0xfff64f59)],
  [Color(0xFFf12711), Color(0xfff5af19)],
  [Color(0xFF009FFF), Color(0xffec2F4B)],
  [Color(0xFFFF416C), Color(0xffFF4B2B)],
  [Color(0xFFa8ff78), Color(0xff78ffd6)],
  [Color(0xFFbc4e9c), Color(0xfff80759)],
  [Color(0xFF11998e), Color(0xff38ef7d)],
  [Color(0xFFff9966), Color(0xffff5e62)],
  [Color(0xFF7F00FF), Color(0xffE100FF)],
  [Color(0xFF36D1DC), Color(0xff5B86E5)],
  [Color(0xFFee0979), Color(0xffff6a00)],
  [Color(0xFF00c3ff), Color(0xffffff1c)],
];
