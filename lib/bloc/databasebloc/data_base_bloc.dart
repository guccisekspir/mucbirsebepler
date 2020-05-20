import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/data/dbRepository.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/user.dart';
import './bloc.dart';

class DataBaseBloc extends Bloc<DataBaseEvent, DataBaseState> {
  DbRepository dbRepository = getIt<DbRepository>();

  @override
  DataBaseState get initialState => InitialDataBaseState();

  @override
  Stream<DataBaseState> mapEventToState(
    DataBaseEvent event,
  ) async* {
    if (event is SaveUserDB) {
      yield DataBaseLoadingState();
      try {
        //repodan al

        User gelenUser = event.user;
        User kaydedilenUser = await dbRepository.saveUser(gelenUser);
        yield DataBaseLoadedState(user: kaydedilenUser);
      } catch (_) {
        debugPrint(_.toString());
        yield DataBaseErrorState();
      }
    }

    if (event is GetUserr) {
      yield DataBaseLoadingState();
      try {
        //repodan al

        String gelenUser = event.userID;
        User kaydedilenUser = await dbRepository.getUser(gelenUser);
        yield DataBaseLoadedState(user: kaydedilenUser);
      } catch (_) {
        debugPrint(_.toString());
        yield DataBaseErrorState();
      }
    }

    if (event is ChangeProfile) {
      bool isPhotoChanged = false;
      bool isUserNameChanged = false;
      debugPrint("Change profile geldi");
      yield DataBaseLoadingState();
      try {
        if (event.newUserName == "") {
          isPhotoChanged = await dbRepository.changePhoto(
              userID: event.userID, newPhoto: event.newPP);
        } else {
          if (event.newPP != null) {
            isPhotoChanged = await dbRepository.changePhoto(
                userID: event.userID, newPhoto: event.newPP);
            isUserNameChanged = await dbRepository.changeUsername(
                userID: event.userID, newUsername: event.newUserName);
          } else {
            isUserNameChanged = await dbRepository.changeUsername(
                userID: event.userID, newUsername: event.newUserName);
          }
        }

        yield DataBaseLoadedState(isChangedPP: isPhotoChanged,isChangedUser: isUserNameChanged);
      } catch (_) {
        debugPrint(_.toString());
        yield DataBaseErrorState();
      }
    }

    if (event is ChangeUserName) {
      bool isNameChanged = false;
      debugPrint("Change profile geldi");
      yield DataBaseLoadingState();
      try {
        isNameChanged = await dbRepository.changeUsername(
            userID: event.userID, newUsername: event.newUserName);
        yield DataBaseLoadedState(isChangedUser: isNameChanged);
      } catch (_) {
        debugPrint(_.toString());
        yield DataBaseErrorState();
      }
    }

    if (event is GetWinnerUsers) {
      yield DataBaseLoadingState();
      try {
        List<User> userList;
        userList = await dbRepository.getWinnerUser();
        yield DataBaseLoadedState(winnerUsers: userList);
      } catch (_) {
        yield DataBaseErrorState();
      }
    }
  }
}
