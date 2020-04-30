

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbApiClient {
  final Firestore _firestore = Firestore.instance;

  Future<bool> saveUser(User user) async {
    DocumentSnapshot gelenUser =
        await Firestore.instance.document("users/${user.userID}").get();
    if (gelenUser == null) {
      await _firestore
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
      return true;
    }else return true;
  }





}
