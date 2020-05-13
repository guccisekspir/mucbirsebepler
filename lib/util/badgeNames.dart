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
      backgroundColor: Colors.pinkAccent,
      radius: 17,
      child: CircleAvatar(
        child: Image.asset('assets/icon/ayin.png',fit: BoxFit.contain,),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),

  CircleAvatar(
      backgroundColor: Colors.pinkAccent,
      radius: 17,
      child: CircleAvatar(
        child: Image.asset('assets/icon/acar.png',fit: BoxFit.contain,),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.pinkAccent,
      radius: 17,
      child: CircleAvatar(
        child: Image.asset('assets/icon/destek.png',fit: BoxFit.contain,),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor:Colors.pinkAccent,
      radius: 17,
      child: CircleAvatar(
        child: Image.asset('assets/icon/yerles.png',fit: BoxFit.contain,),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.pinkAccent,
      radius: 17,
      child: CircleAvatar(
        child: Image.asset('assets/icon/popular.png',fit: BoxFit.contain,),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),
  CircleAvatar(
      backgroundColor: Colors.pinkAccent,
      radius: 17,
      child: CircleAvatar(
        child: Image.asset('assets/icon/tospik.png',fit: BoxFit.contain,),
        radius: 14,
        backgroundColor: Colors.limeAccent,
      )),

];