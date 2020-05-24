import 'package:mucbirsebepler/data/authApiClient.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/user.dart';

class AuthRepository {
  AuthApiClient _authApiClient = getIt<AuthApiClient>();

  Future<User> createWithEmailPass(String email, String password) async {
    User user = await _authApiClient.createWithEmailPass(email, password);

    return user;
  }

  Future<User> loginWithEmailPass(String email, String password) async {
    User user = await _authApiClient.loginWithEmailPass(email, password);

    return user;
  }

  Future<User> googleSign() async {
    User user = await _authApiClient.googleSign();

    return user;
  }

  Future<void> forgetPassword(String email) async {
    await _authApiClient.forgetPassword(email);
  }

  Future<bool> signOut() async {
    return await _authApiClient.signOut();
  }
}
