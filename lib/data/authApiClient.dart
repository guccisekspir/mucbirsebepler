

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mucbirsebepler/model/user.dart';

class AuthApiClient{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;


  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(userID: user.uid, email: user.email);
    }
  }




  Future<User> createWithEmailPass(String email,String password)async{
    AuthResult _authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(_authResult.user);
  }

  Future<User> loginWithEmailPass(String email,String password)async{
    AuthResult _authResult=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(_authResult.user);
  }







}