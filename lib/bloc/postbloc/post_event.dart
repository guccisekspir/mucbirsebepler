import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/model/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class SavePost extends PostEvent {
  final Post gelenPost;

  SavePost({this.gelenPost});

  @override
  List<Object> get props => [gelenPost];
}

class GetPost extends PostEvent{
  @override
  List<Object> get props => null;


}


class GetMorePost extends PostEvent{
  @override
  List<Object> get props => null;


}

class LikePost extends PostEvent{
  final String userID;
  final String postID;

  LikePost({this.postID,this.userID});
  @override
  List<Object> get props => throw UnimplementedError();

}

class GetUserPopulars extends  PostEvent{
  final String userID;

  GetUserPopulars(this.userID);
  @override
  List<Object> get props => [userID];


}