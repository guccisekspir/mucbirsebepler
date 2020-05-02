import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/data/authRepository.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/user.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is EmailSign) {
      yield AuthLoadingState();
      try {
        String email = event.email;
        String password = event.password;

        User user = await _authRepository.createWithEmailPass(email, password);

        yield AuthLoadedState(user: user);
      } catch (_) {
        yield AuthErrorState();
        debugPrint(_.toString());
      }
    } else if (event is EmailLogin) {
      yield AuthLoadingState();
      try {
        String email = event.email;
        String password = event.password;

        User user = await _authRepository.loginWithEmailPass(email, password);

        yield AuthLoadedState(user: user);
      } catch (_) {
        yield AuthErrorState();
        debugPrint(_.toString());
      }
    } else if (event is GoogleSign) {
      yield AuthLoadingState();
      try {
        User user = await _authRepository.googleSign();

        yield AuthLoadedState(user: user);
      } catch (_) {
        yield AuthErrorState();
        debugPrint(_.toString());
      }
    } else if (event is ForgetPass) {
      yield ForgetLoadingState();
      try {
        await _authRepository.forgetPassword(event.email);
        yield ForgetLoadedState();
      } catch (_) {
        yield ForgetErrorState(_.toString());
        debugPrint(_.toString());
      }
    }
  }
}
