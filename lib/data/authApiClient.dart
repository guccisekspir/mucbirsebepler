

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<User> googleSign() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthResult sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        FirebaseUser _user = sonuc.user;
        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }







}