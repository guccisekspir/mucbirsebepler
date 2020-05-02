import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => InitialPostState();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
