import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class InitialPostState extends PostState {
  @override
  List<Object> get props => [];
}
//Post Getirme Stateleri
class PostLoadingState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostLoadedState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostErrorState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

//Post kaydetme stateleri

class PostFetchingState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostFetchComplateState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PostFetchErrorState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
