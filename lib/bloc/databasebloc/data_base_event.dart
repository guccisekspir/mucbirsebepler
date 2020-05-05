import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/model/user.dart';

abstract class DataBaseEvent extends Equatable {
  const DataBaseEvent();
}


class SaveUserDB extends DataBaseEvent{
  final User user;

  SaveUserDB({this.user});
  @override
  // TODO: implement props
  List<Object> get props => [user];


}

class GetUserr extends DataBaseEvent{
final String userID;

GetUserr({this.userID});
@override
// TODO: implement props
List<Object> get props => [userID];
}
