

import 'dart:math';

import 'package:flutter/material.dart';



LinearGradient randomGradient(){
  return LinearGradient(
      colors: gradientColorsList[Random().nextInt(20)]
  );
}




List<List<Color>> gradientColorsList=[
  [Color(0xFF00C9FF),Color(0xff92FE9D)],
  [Color(0xFFFFB75E),Color(0xffED8F03)],
  [Color(0xFFB24592),Color(0xffF15F79)],
  [Color(0xFFe96443),Color(0xff904e95)],
  [Color(0xFFf79d00),Color(0xff64f38c)],
  [Color(0xFF12c2e9),Color(0xffc471ed),Color(0xfff64f59)],
  [Color(0xFFf12711),Color(0xfff5af19)],
  [Color(0xFF8360c3),Color(0xff2ebf91)],
  [Color(0xFF009FFF),Color(0xffec2F4B)],
  [Color(0xFFFF416C),Color(0xffFF4B2B)],
  [Color(0xFFa8ff78),Color(0xff78ffd6)],
  [Color(0xFFbc4e9c),Color(0xfff80759)],
  [Color(0xFF11998e),Color(0xff38ef7d)],
  [Color(0xFFFC5C7D),Color(0xff6A82FB)],
  [Color(0xFFCAC531),Color(0xffF3F9A7)],
  [Color(0xFFff9966),Color(0xffff5e62)],
  [Color(0xFF7F00FF),Color(0xffE100FF)],
  [Color(0xFF36D1DC),Color(0xff5B86E5)],
  [Color(0xFF4568DC),Color(0xffB06AB3)],
  [Color(0xFFDCE35B),Color(0xff45B649)],
  [Color(0xFFee0979),Color(0xffff6a00)],
  [Color(0xFFf4c4f3),Color(0xfffc67fa)],


];



