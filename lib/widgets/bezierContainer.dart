import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  final bool kayitMi;

  const BezierContainer({Key key,this.kayitMi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color1=kayitMi?Colors.black87:Colors.limeAccent;
    Color color2=kayitMi?Colors.black:Colors.lime;
    return Container(
        child: Transform.rotate(
          angle: -pi / 3.5,
          child: ClipPath(
            clipper: ClipPainter(),
            child: Container(
              height: MediaQuery.of(context).size.height *.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [color1,color2]
                  )
              ),
            ),
          ),
        )
    );
  }
}