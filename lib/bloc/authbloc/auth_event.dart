import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class EmailLogin extends AuthEvent {
  final String email;
  final String password;

  EmailLogin({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class EmailSign extends AuthEvent {
  final String email;
  final String password;

  EmailSign({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class GoogleSign extends AuthEvent {
  @override
  List<Object> get props => null;
}

class ForgetPass extends AuthEvent {
  final String email;

  ForgetPass({this.email});

  @override
  List<Object> get props => [email];
}

class SignOut extends AuthEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
