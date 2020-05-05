import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/data/dbRepository.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/post.dart';
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
      yield PostSavingState();
      try{
        await _dbRepository.savePost(event.gelenPost);
        await _dbRepository.getPost();
        debugPrint("bloc denemeye geldi");
        yield PostSavedState();
      }catch(_){
        debugPrint(_.toString());
        yield PostSaveErrorState();
      }

    }

    if(event is GetPost){
      yield PostLoadingState();
      try{
        List<Post> lisPost=await _dbRepository.getAllPost();
        yield PostLoadedState(listPost: lisPost);
      }catch(_){
        yield PostErrorState();
      }
    }
  }
}
