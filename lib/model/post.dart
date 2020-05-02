import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:mucbirsebepler/model/user.dart';

class Post {
  final User owner;
  final String title;


  final String description;
  final String youtubelink;
  final String otherLink;
  String postID;
  int liked = 0;
  DateTime createdAt;

  Post(
      {@required this.owner, @required this.title, @required this.description, this.youtubelink, this.otherLink});


  Map<String, dynamic> toMap() {
    return {
      'owner': owner,
      'title': title,
      'description': description,
      'youtubelink': youtubelink,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'otherLink': otherLink,
      'postID': postID,
      'liked': liked,
    };
  }

  Post.fromMap(Map<String, dynamic> map)
      : owner = map['owner'],
        title = map['title'],
        description = map['description'],
        youtubelink = map['youtubelink'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        otherLink=map['otherLink'],
        postID = map['postID'],
        liked = map['liked'];


  @override
  String toString() {
    return 'Post{owner: $owner, title: $title, description: $description, youtubelink: $youtubelink, otherLink: $otherLink, postID: $postID, liked: $liked, createdAt: $createdAt}';
  }








