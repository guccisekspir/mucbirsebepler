import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/util/badgeNames.dart';
import 'package:mucbirsebepler/widgets/randomGradient.dart';

Widget profilePicture(String url,BuildContext context){
  return CircleAvatar(
    backgroundColor: Theme.of(context).accentColor,
    radius: 95,
    child: CircleAvatar(
      backgroundImage: NetworkImage(url),
      radius: 80,  //TODO radiusları mediaquerye göre yap
      backgroundColor: Theme.of(context).accentColor,
    ),
  );
}

Widget profilePicturew(String url,BuildContext context){
  return Container(
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [

      Align(
        alignment: Alignment.bottomCenter,
        child: Container(

          width: 160,
          height: 160,
          decoration: BoxDecoration(
            gradient: randomGradient(),
              color: Colors.limeAccent,
            shape: BoxShape.circle
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: CircleAvatar(
          backgroundImage: NetworkImage(url),
          radius: 70,  //TODO radiusları mediaquerye göre yap
          backgroundColor: Theme.of(context).accentColor,
        ),
      ),
    ],),
  );
}



Widget badgeMaker(int index, User gelenUser) {
  return FittedBox(
    child: Container(
      decoration: BoxDecoration(
          gradient: randomGradient(),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          badgeIcons[index],
          Text(
            badgeNames[index],
            style:
            GoogleFonts.righteous(fontSize: 10, color: Colors.black),
          )
        ],
      ),
    ),
  );
}