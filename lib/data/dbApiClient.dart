import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbApiClient {
  final Firestore _firestore = Firestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference;
  QuerySnapshot _querySnapshot;
  var lastDocument;

  Future<User> saveUser(User user) async {
    DocumentSnapshot gelenUser =
        await Firestore.instance.document("users/${user.userID}").get();
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

  Future<User> getUser(String userID) async {
    DocumentSnapshot gelenUser =
        await Firestore.instance.document("users/$userID").get();
    User okunanUser = User.fromMap(gelenUser.data);
    okunanUser.roller = gelenUser.data['roller'];
    return okunanUser;
  }



  Future<bool> changeUsername({String userID, String newUsername}) async {
    var users = await _firestore
        .collection("users")
        .where("userName", isEqualTo: newUsername)
        .getDocuments();
    if (users.documents.length >= 1) {
      return false;
    } else {
      await _firestore
          .collection("users")
          .document(userID)
          .updateData({'userName': newUsername});
      return true;
    }
  }

  Future<bool> changePhoto({String userID, File newPhoto}) async {
    _storageReference = _firebaseStorage.ref().child(userID).child("profilPhoto.png");
    StorageUploadTask uploadTask = _storageReference.putFile(newPhoto);

    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    if (url != null) {
      await _firestore
          .collection("users")
          .document(userID)
          .updateData({'profilURL': url});
      return true;
    } else
      return false;
  }

  Future<bool> savePost(Post post) async {
    //TODO düzenlenecek

    var userMap = post.toMap();
    var postID = userMap['postID'];
    try {
      await _firestore.collection("posts").document(postID).setData(userMap);
      await _firestore
          .collection("users")
          .document(post.owner.userID)
          .collection("posts")
          .document(postID)
          .setData(userMap);
    } catch (_) {}
  }

  Future<void> likePost(
      String postID, String userID, String ownerUserID) async {
    DocumentSnapshot likedDocument;

    likedDocument = await _firestore
        .collection("posts")
        .document(postID)
        .collection("likedBy")
        .document(userID)
        .get();

    if (likedDocument.data == null) {
      _firestore
          .collection("users")
          .document(ownerUserID)
          .updateData({"liked": FieldValue.increment(1)});

      _firestore
          .collection("posts")
          .document(postID)
          .updateData({"liked": FieldValue.increment(1)});
      _firestore
          .collection("posts")
          .document(postID)
          .collection("likedBy")
          .document(userID)
          .setData({"eben": true});
    }
  }
  Future<List<User>> getWinnerUser()async{
    List<User> listWinner=[];
    QuerySnapshot _userQuery;

    _userQuery= await Firestore.instance.collection("users").orderBy("liked",descending: true).limit(50).getDocuments();
    for(DocumentSnapshot documentSnapshot in _userQuery.documents){
      User tekUser = User.fromMap(documentSnapshot.data);
      listWinner.add(tekUser);
    }

    return listWinner;
  }

  Future<List<Post>> getAllPost(Post lastFetched, int fetchLimit) async {
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
          .startAfterDocument(lastDocument)
          .limit(fetchLimit)
          .getDocuments();
    }
    if (_querySnapshot.documents.length != 0) {
      lastDocument =
          _querySnapshot.documents[_querySnapshot.documents.length - 1];
    }

    for (DocumentSnapshot documentSnapshot in _querySnapshot.documents) {
      Post tekPost = Post.fromMap(documentSnapshot.data);
      _postList.add(tekPost);
    }
    return _postList;
  }

  Future<List<Post>> getUserPopular(String userID) async {
    QuerySnapshot _querySnapshotss;
    List<Post> _mostPopular = [];
    _querySnapshotss = await Firestore.instance
        .collection("users")
        .document(userID)
        .collection("posts")
        .orderBy("liked", descending: false)
        .limit(3)
        .getDocuments();
    for (DocumentSnapshot documentSnapshot in _querySnapshotss.documents) {
      Post tekPost = Post.fromMap(documentSnapshot.data);
      _mostPopular.add(tekPost);
    }

    return _mostPopular;
  }
}
