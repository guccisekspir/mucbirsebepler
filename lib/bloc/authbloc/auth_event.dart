import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/data/authRepository.dart';
import 'package:mucbirsebepler/locator.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}


class EmailLogin extends AuthEvent{
  AuthRepository _authRepository= getIt<AuthRepository>();
  final String email;
  final String password;
  EmailLogin({this.email, this.password});

  @override
  List<Object> get props => [email,password];

}

class EmailSign extends AuthEvent{
  @override
  List<Object> get props => null;

}
