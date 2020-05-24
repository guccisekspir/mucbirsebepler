import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/model/post.dart';

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
  List<Object> get props => null;
}

class MoreLoadingState extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PostLoadedState extends PostState {
  final List<Post> listPost;

  PostLoadedState({this.listPost});

  @override
  List<Object> get props => [listPost];
}

class PostErrorState extends PostState {
  @override
  List<Object> get props => null;
}

//Post kaydetme stateleri

class PostSavingState extends PostState {
  @override
  List<Object> get props => null;
}

class PostSavedState extends PostState {
  @override
  List<Object> get props => null;
}

class PostSaveErrorState extends PostState {
  @override
  List<Object> get props => null;
}
