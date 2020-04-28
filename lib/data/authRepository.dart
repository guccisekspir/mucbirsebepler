


import 'package:mucbirsebepler/data/authApiClient.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/user.dart';

class AuthRepository{
  AuthApiClient _authApiClient= getIt<AuthApiClient>();
  Future<User> createWithEmailPass(String email,String password)async{
    User user= await _authApiClient.createWithEmailPass(email, password);

    return user;

  }




}