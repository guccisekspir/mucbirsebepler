
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbApiClient {
  final Firestore _firestore = Firestore.instance;

  Future<bool> saveUser(User user) async {
    debugPrint("apiye geliyo");
    DocumentSnapshot gelenUser =
        await Firestore.instance.document("users/${user.userID}").get();
    debugPrint(gelenUser.toString());
    if(gelenUser.data==null){
      await _firestore
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
      debugPrint(gelenUser.toString());
      return true;
    }else return true;


  }

  Future<bool>savePost(Post post)async{ //TODO düzenlenecek
    await _firestore.collection("posts").document("eben").setData(post.toMap());
  }

  Future<Post>getPost()async{
    DocumentSnapshot gelen= await _firestore.collection("posts").document("eben").get();

    Post gelenPost= Post.fromMap(gelen.data);
    debugPrint(gelenPost.toString());

  }







}
