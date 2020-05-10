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
  bool isVerified;
  bool isFamous;
  bool isFirst;
  Map<String,dynamic> roller={"aym":false,"acM":false,"matik":false,"gMatik":false,"destekci":false};


  User({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName':
      userName ?? email.substring(0, email.indexOf('@')) + randomSayiUret(),
      'profilURL': profilURL ?? 'https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1,
      'isVerified': isVerified ?? false,
      'isFamous':isFamous?? false,
      'isFirst':isFirst??true,
      'roller':roller
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        isFirst=map['isFirst'],
        seviye = map['seviye'];

  User.idveResim({@required this.userID, @required this.profilURL});

  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, seviye: $seviye, isVerified: $isVerified, isFamous: $isFamous,isFirst: $isFirst';
  }

  String randomSayiUret() {
    int rastgeleSayi = Random().nextInt(999);
    return rastgeleSayi.toString();
  }
}