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
      backgroundColor: Colors.black,
      radius: 17,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/ayin.png'),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),

  CircleAvatar(
      backgroundColor: Colors.black,
      radius: 17,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/acar.png'),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.black,
      radius: 17,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/destek.png',),

        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.black,
      radius: 17,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/yerles.png'),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.black,
      radius: 17,
      child: CircleAvatar(

        backgroundImage: AssetImage('assets/icon/popular.png'),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.black,
      radius: 17,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/icon/tospik.png'),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),

];