import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user.dart';
import 'package:mucbirsebepler/model/user.dart';

class Post {
  final User owner;
  final String title;
  final String description;
  final String youtubelink;
  final String otherLink;
  final String ownerUserName;
  final String ownerProfileURL;
  String postID;
  int liked = 0;
  DateTime createdAt;

  Post(
      {@required this.owner,
      @required this.title,
      @required this.description,
      this.youtubelink, this.ownerUserName,this.ownerProfileURL,
      this.otherLink}) {
    debugPrint(owner.toString());
  }

  Map<String, dynamic> toMap() {
    return {
      'owner': owner.toMap(),
      'title': title,
      'description': description,
      'youtubelink': youtubelink ?? "",
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'otherLink': otherLink ?? "",
      'postID': owner.userID + randomSayiUret(),
      'ownerUserName':ownerUserName,
      'ownerProfileURL':ownerProfileURL,
      'liked': liked ?? 0,
    };
  }

  Post.fromMap(Map<String, dynamic> map)
      : owner = User.fromMap(map['owner']),
        title = map['title'],
        description = map['description'],
        youtubelink = map['youtubelink'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        otherLink = map['otherLink'],
        postID = map['postID'],
        ownerUserName=map['ownerUserName'],
        ownerProfileURL=map['ownerProfileURL'],
        liked = map['liked'];

  @override
  String toString() {
    return 'Post{owner: $owner, title: $title, description: $description, youtubelink: $youtubelink, otherLink: $otherLink, postID: $postID, liked: $liked, createdAt: $createdAt}';
  }

  String randomSayiUret() {
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }
}
