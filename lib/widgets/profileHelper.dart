import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/util/badgeNames.dart';
import 'package:mucbirsebepler/widgets/randomGradient.dart';

Widget profilePicture(String url, BuildContext context, {File gelenFoto}) {
  ImageProvider image = NetworkImage(url);
  if (gelenFoto != null) {
    image = FileImage(gelenFoto);
  }
  return CircleAvatar(
    backgroundColor: Theme.of(context).accentColor,
    radius: 95,
    child: CircleAvatar(
      backgroundImage: image,
      radius: 80, //TODO radiusları mediaquerye göre yap
      backgroundColor: Theme.of(context).accentColor,
    ),
  );
}

Widget profilePicturew(User user, BuildContext context,
    {LinearGradient linearGradient, File gelenFoto, String profileURL}) {
  LinearGradient gradient = randomGradient();
  if (linearGradient != null) {
    gradient = linearGradient;
  }
  ImageProvider image = NetworkImage(user.profilURL);
  if (gelenFoto != null) {
    image = FileImage(gelenFoto);
  }

  return Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                    gradient: gradient,
                    color: Colors.limeAccent,
                    shape: BoxShape.circle),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundImage: image,
                radius: 70, //TODO radiusları mediaquerye göre yap
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
      user.isGmatik
          ? Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 130),
                child: Container(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      "assets/renkli.gif",
                      fit: BoxFit.fill,
                    )),
              ),
            )
          : SizedBox(
              height: 0,
              width: 0,
            ),
      user.isMatik
          ? Padding(
              padding: const EdgeInsets.only(left: 130),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      "assets/renksiz.gif",
                      fit: BoxFit.fill,
                    )),
              ),
            )
          : SizedBox(
              height: 0,
              width: 0,
            ),
    ],
  );
}

Widget badgeMaker(int index, User gelenUser, String rol) {
  LinearGradient randomGradientt = randomGradient();

  int buldugumindex;
  for (int i = 0; i < firebaseBadgeNames.length; i++) {
    if (firebaseBadgeNames[i] == rol) {
      buldugumindex = i;
      break;
    }
  }

  return FittedBox(
    child: Container(
      decoration: BoxDecoration(
          gradient: randomGradientt, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          badgeIcons[buldugumindex],
          Text(
            badgeNames[buldugumindex],
            style: GoogleFonts.righteous(fontSize: 10, color: Colors.black),
          )
        ],
      ),
    ),
  );
}
