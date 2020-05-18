import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/model/user.dart';

abstract class DataBaseEvent extends Equatable {
  const DataBaseEvent();
}


class SaveUserDB extends DataBaseEvent{
  final User user;

  SaveUserDB({this.user});
  @override
  List<Object> get props => [user];


}

class GetUserr extends DataBaseEvent{
final String userID;

GetUserr({this.userID});
@override

List<Object> get props => [userID];
}

class ChangeProfile extends DataBaseEvent{
  final String userID;
  final File newPP;
  final String newUserName;

  ChangeProfile({this.userID,this.newPP,this.newUserName});
  @override
  // TODO: implement props
  List<Object> get props => [userID,newPP];


}
class ChangeUserName extends DataBaseEvent{
  final String userID;
  final String newUserName;

  ChangeUserName({this.userID,this.newUserName});
  @override
  // TODO: implement props
  List<Object> get props => [userID,newUserName];

}

class GetWinnerUsers extends DataBaseEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}




