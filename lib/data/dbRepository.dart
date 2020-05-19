import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mucbirsebepler/data/dbApiClient.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbRepository {
  List<Post> _postList;
  List<Post> _newPostList = [];
  Post _lastFetchedPost;
  static final postLimitNumber = 4;
  bool hasMore = true;
  bool istendiMi = true;
  bool ilkMi = true;

  DbRepository() {
    _postList = [];
    _lastFetchedPost = null;
  }

  DbApiClient _dbApiClient = getIt<DbApiClient>();

  Future<User> saveUser(User user) async {
    return await _dbApiClient.saveUser(user);
  }

  Future<User> getUser(String userID) async {
    return await _dbApiClient.getUser(userID);
  }

  Future<bool> savePost(Post post) async {
    return await _dbApiClient.savePost(post);
  }

  Future<List<Post>> getAllPost({Post lastPost}) async {
    if (_postList.length > 0) {
      _lastFetchedPost = _postList.last;
      if (istendiMi) {
        return _postList;
      }
    }

    List<Post> gelenList =
        await _dbApiClient.getAllPost(_lastFetchedPost, postLimitNumber);

    _postList.addAll(gelenList);
    if (gelenList.length > postLimitNumber)
      hasMore =
          false; //Burada çekilen son liste sayısı belirlediğimiz limitten küçükse bir daha çağırılmamasını sağlıyoruz

    List<Post> _gideceklist = _postList;
    return _gideceklist;
  }

  Future<List<Post>> getMorePost() async {
    istendiMi = false;
    if (hasMore) return await getAllPost(lastPost: _lastFetchedPost);
  }

  Future<List<Post>> getUserPosts(String userID) async {
    return await _dbApiClient.getUserPopular(userID);
  }

  Future<List<Post>> getNewsPost() async {
    List<Post> gelenListe = await _dbApiClient.getNewsPost(ilkMi);
    _newPostList.addAll(gelenListe);
    List<Post> _gidecekkList = _newPostList;
    return _gidecekkList;
  }

  Future<List<Post>> getMoreNewsPost() async {
    ilkMi = false;
    return await getNewsPost();
  }

  Future<List<User>> getWinnerUser() async {
    return await _dbApiClient.getWinnerUser();
  }

  Future<void> likePost(
      String postID, String userID, String ownerUserID) async {
    return await _dbApiClient.likePost(postID, userID, ownerUserID);
  }

  Future<Null> refresh() async {
    _dbApiClient.refresh();
    hasMore = true;
    _lastFetchedPost = null;
    ilkMi = true;
    _newPostList = [];
    _postList = [];
  }

  Future<bool> changeUsername({String userID, String newUsername}) async {
    debugPrint("change user repo geldi");
    return await _dbApiClient.changeUsername(
        userID: userID, newUsername: newUsername);
  }

  Future<bool> changePhoto({String userID, File newPhoto}) async {
    debugPrint("repoya geldi");
    return await _dbApiClient.changePhoto(userID: userID, newPhoto: newPhoto);
  }
}
