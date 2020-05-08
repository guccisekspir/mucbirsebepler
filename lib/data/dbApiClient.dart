import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbApiClient {
  final Firestore _firestore = Firestore.instance;
  QuerySnapshot _querySnapshot;
  var lastDocument;

  Future<User> saveUser(User user) async {
    DocumentSnapshot gelenUser =
        await Firestore.instance.document("users/${user.userID}").get();
    debugPrint(gelenUser.toString());
    if (gelenUser.data == null) {
      await _firestore
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
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
    debugPrint("post id is "+post.postID);

    await _firestore
        .collection("posts")
        .document(post.postID)
        .setData(post.toMap());
  }

  Future<Post> getPost() async {
    DocumentSnapshot gelen =
        await _firestore.collection("posts").document().get();

    Post gelenPost = Post.fromMap(gelen.data);

    return gelenPost;
  }

  Future<void> likePost(String postID)async{



  }

  Future<List<Post>> getAllPost(Post lastFetched, int fetchLimit) async {

    List<Post> _postList = [];
    if (lastFetched == null) {
      debugPrint("nulla giriyo");
      _querySnapshot = await Firestore.instance
          .collection("posts")
          .orderBy("liked", descending: true)
          .limit(fetchLimit)
          .getDocuments();
    } else {
      debugPrint("else girioy"+lastFetched.postID);
      _querySnapshot = await Firestore.instance
          .collection("posts")
          .orderBy("liked", descending: true)
          .startAfterDocument(lastDocument)
          .limit(fetchLimit)
          .getDocuments();
    }
    if(_querySnapshot.documents.length!=0){
      lastDocument = _querySnapshot.documents[_querySnapshot.documents.length - 1];
    }



    for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {

      Post tekPost = Post.fromMap(documentSnapshot.data);
      _postList.add(tekPost);
    }
    return _postList;
  }




}
