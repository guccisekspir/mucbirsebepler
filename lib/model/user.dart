import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  int seviye;
  bool isGmatik;
  bool isMatik;
  bool isFirst;
  int liked;
  Map<String,dynamic> roller={"aym":false,"acM":false,"destekci":false,"yerlestirici":false,"popular":false,"tospik":true};


  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, seviye: $seviye, isGmatik: $isGmatik, isMatik: $isMatik, isFirst: $isFirst, roller: $roller}';
  }

  User({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName':
      userName ?? email.substring(0, email.indexOf('@')) + randomSayiUret(),
      'profilURL': profilURL ?? 'https://scontent-iad3-1.cdninstagram.com/v/t51.2885-19/93015989_334674204174771_8234711126986719232_n.jpg?_nc_ht=scontent-iad3-1.cdninstagram.com&_nc_ohc=768rEmsjt9QAX85AVxd&oh=15d0af9622c40769173994595367f79b&oe=5EE5599D',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1,
      'isGmatik': isGmatik ?? false,
      'isMatik':isMatik?? false,
      'isFirst':isFirst??true,
      'roller':roller,
      'liked':liked??0
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        isGmatik=map['isGmatik'],
        isMatik=map['isMatik'],
        isFirst=map['isFirst'],
        seviye = map['seviye'],
        roller=map['roller'],
        liked=map['liked'];

  User.idveResim({@required this.userID, @required this.profilURL});



  String randomSayiUret() {
    int rastgeleSayi = Random().nextInt(999);
    return rastgeleSayi.toString();
  }
}