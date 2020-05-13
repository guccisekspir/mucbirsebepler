import 'package:mucbirsebepler/data/dbApiClient.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';

class DbRepository {
  List<Post> _postList;
  Post _lastFetchedPost;
  static final postLimitNumber = 4;
  bool hasMore = true;
  bool istendiMi = true;

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

  Future<List<Post>> getUserPosts(String userID)async{

    return await _dbApiClient.getUserPopular(userID);
  }

  Future<void> likePost(String postID,String userID,String ownerUserID) async {
    return await _dbApiClient.likePost(postID,userID,ownerUserID);
  }

  Future<Null> refresh() async {
    hasMore = true;
    _lastFetchedPost = null;
    _postList = [];
    getAllPost(lastPost: _lastFetchedPost);
  }
}
