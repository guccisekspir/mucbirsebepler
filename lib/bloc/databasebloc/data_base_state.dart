import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/model/user.dart';

abstract class DataBaseState extends Equatable {
  const DataBaseState();
}

class InitialDataBaseState extends DataBaseState {
  @override
  List<Object> get props => [];
}

class DataBaseLoadingState extends DataBaseState{
  @override

  List<Object> get props => null;
}
class DataBaseLoadedState extends DataBaseState{
  final User user;
  final bool isChanged;

  DataBaseLoadedState({this.user,this.isChanged});
  @override

  List<Object> get props => [user];
}
class DataBaseErrorState extends DataBaseState{
  @override

  List<Object> get props => null;
}


