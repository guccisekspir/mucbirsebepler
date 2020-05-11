import 'package:flutter/material.dart';


List<String> firebaseBadgeNames=[
  "aym",
  "acM",
  "destekci",
  "yerlestirici",
  "popular",
  "tospik"
];

List<String> badgeNames=[
  " Ayın Muhabiri ",
  " Acar Muhabir ",
  " Destekçi Tospik ",
  " Ürün Yerleştirici ",
  " Popüler Tospik ",
  " Tospik "
];


List<Widget> badgeIcons=[

  CircleAvatar(
      backgroundColor: Colors.limeAccent,
      radius: 12,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/ayin.png'),
        radius: 10,
        backgroundColor: Colors.limeAccent,
      )),

  CircleAvatar(
      backgroundColor: Colors.limeAccent,
      radius: 12,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/acar.png'),
        radius: 10,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.limeAccent,
      radius: 12,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/destek.png',),

        radius: 10,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.limeAccent,
      radius: 12,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/yerles.png'),
        radius: 10,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.limeAccent,
      radius: 12,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/popular.png'),
        radius: 10,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.limeAccent,
      radius: 12,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/tospik.png'),
        radius: 10,
        backgroundColor: Colors.limeAccent,
      )),

];