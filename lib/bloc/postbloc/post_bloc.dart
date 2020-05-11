import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/data/dbRepository.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/post.dart';
import './bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  List<Post> listPost=[];
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
        debugPrint("bloc denemeye geldi");
        yield PostSavedState();
      }catch(_){
        debugPrint("savede hata "+_.toString());
        yield PostSaveErrorState();
      }

    }
    if(event is GetPost){
      yield PostLoadingState();
      try{
        listPost=await _dbRepository.getAllPost();
        yield PostLoadedState(listPost: listPost);
      }catch(_){
        debugPrint("getpost "+_.toString());
        yield PostErrorState();
      }
    }

    if(event is GetMorePost){
      yield PostLoadingState();
      try{
        listPost=await _dbRepository.getMorePost();
        yield PostLoadedState(listPost: listPost);

      }catch(_){
        debugPrint(_.toString());
        yield PostErrorState();
      }
    }

    if(event is GetUserPopulars){
      yield PostLoadingState();
      try{
        var listePost= await _dbRepository.getUserPosts(event.userID);
        yield PostLoadedState(listPost: listePost);

      }catch(_){
        debugPrint("getuserda hata "+_.toString());
      }
    }


    if(event is LikePost){
      await _dbRepository.likePost(event.postID);
    }
  }
}
