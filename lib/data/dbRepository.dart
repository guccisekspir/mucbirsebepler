


import 'package:mucbirsebepler/data/dbApiClient.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbRepository{
  List<Post> _postList;
  Post _lastFetchedPost;
  static final postLimitNumber=5;
  bool hasMore=true;

  DbRepository(){
    _postList=[];
    _lastFetchedPost=null;
  }


  DbApiClient _dbApiClient= getIt<DbApiClient>();

  Future<bool> saveUser(User user)async{

    return await _dbApiClient.saveUser(user);
  }

  Future<bool> savePost(Post post)async{
    return await _dbApiClient.savePost(post);
  }

  Future<Post> getPost()async{
    return await _dbApiClient.getPost();
  }

  Future<List<Post>> getAllPost({Post lastPost})async{

    if(_postList.length>0){
      _lastFetchedPost=_postList.last;
    }

    List<Post> gelenList = await _dbApiClient.getAllPost(_lastFetchedPost,postLimitNumber);

    _postList.addAll(gelenList);
    if(gelenList.length>postLimitNumber) hasMore=false; //Burada çekilen son liste sayısı belirlediğimiz limitten küçükse bir daha çağırılmamasını sağlıyoruz

    return _postList;




  }

  Future<List<Post>> getMorePost()async{
    if(hasMore) return await getAllPost(lastPost: _lastFetchedPost);

  }

  Future<Null> refresh() async {
    hasMore = true;
    _lastFetchedPost = null;
    _postList = [];
    getAllPost(lastPost: _lastFetchedPost);
  }



}