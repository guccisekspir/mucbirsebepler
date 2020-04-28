import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/model/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}


class AuthLoadingState extends AuthState{


  @override
  // TODO: implement props
  List<Object> get props => null;
}
class AuthLoadedState extends AuthState{
  User _user;
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class AuthErrorState extends AuthState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}