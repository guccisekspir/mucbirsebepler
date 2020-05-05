import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbApiClient {
  final Firestore _firestore = Firestore.instance;

  Future<User> saveUser(User user) async {
    debugPrint("apiye geliyo");
    DocumentSnapshot gelenUser =
        await Firestore.instance.document("users/${user.userID}").get();
    debugPrint(gelenUser.toString());
    if (gelenUser.data == null) {
      await _firestore
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
      debugPrint(gelenUser.toString());

      Map<String, dynamic> _okunanUserBilgileriMap = gelenUser.data;
      User okunanUser = User.fromMap(_okunanUserBilgileriMap);
      return okunanUser;
    } else {
      User okunanUser = User.fromMap(gelenUser.data);
      return okunanUser;
    }
  }


  Future<User>getUser(String userID) async{
    DocumentSnapshot gelenUser =
    await Firestore.instance.document("users/$userID").get();
    User okunanUser = User.fromMap(gelenUser.data);
    return okunanUser;

  }


  Future<bool> savePost(Post post) async {
    //TODO düzenlenecek

    await _firestore
        .collection("posts")
        .document(post.postID)
        .setData(post.toMap());
  }

  Future<Post> getPost() async {
    DocumentSnapshot gelen =
        await _firestore.collection("posts").document().get();

    Post gelenPost = Post.fromMap(gelen.data);
    debugPrint(gelenPost.toString());

    return gelenPost;
  }

  Future<List<Post>> getAllPost(Post lastFetched, int fetchLimit) async {
    QuerySnapshot _querySnapshot;
    List<Post> _postList = [];
    if (lastFetched == null) {
      _querySnapshot = await Firestore.instance
          .collection("posts")
          .orderBy("liked", descending: true)
          .limit(fetchLimit)
          .getDocuments();
    } else {
      _querySnapshot = await Firestore.instance
          .collection("posts")
          .orderBy("liked", descending: true)
          .startAfter([lastFetched.postID])
          .limit(fetchLimit)
          .getDocuments();
    }

    for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {
      Post tekPost = Post.fromMap(documentSnapshot.data);
      _postList.add(tekPost);
      debugPrint(tekPost.toString());
    }
    return _postList;
  }


}
