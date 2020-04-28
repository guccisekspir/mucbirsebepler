import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}


class EmailLogin extends AuthEvent{
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
