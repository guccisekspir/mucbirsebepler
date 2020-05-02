import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:mucbirsebepler/data/dbRepository.dart';
import 'package:mucbirsebepler/locator.dart';
import './bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => InitialPostState();
  DbRepository _dbRepository=getIt<DbRepository>();
  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if(event is SavePost){
      yield PostFetchingState();
      try{
        await _dbRepository.savePost(event.gelenPost);
        yield PostFetchComplateState();
      }catch(_){
        yield PostFetchErrorState();
      }

    }
  }
}
