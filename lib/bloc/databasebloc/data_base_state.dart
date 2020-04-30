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
  // TODO: implement props
  List<Object> get props => null;
}
class DataBaseLoadedState extends DataBaseState{
  final bool isOK;

  DataBaseLoadedState({this.isOK});
  @override
  // TODO: implement props
  List<Object> get props => [isOK];
}
class DataBaseErrorState extends DataBaseState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

