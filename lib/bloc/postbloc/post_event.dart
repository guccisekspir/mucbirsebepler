import 'package:equatable/equatable.dart';
import 'package:mucbirsebepler/data/dbRepository.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/model/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class SavePost extends PostEvent {
  final Post gelenPost;

  SavePost({this.gelenPost});

  @override
  // TODO: implement props
  List<Object> get props => [gelenPost];
}

class GetPost extends PostEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;


}


class GetMorePost extends PostEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;


}

class LikePost extends PostEvent{
  final String postID;

  LikePost({this.postID});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class GetUserPopulars extends  PostEvent{
  final String userID;

  GetUserPopulars(this.userID);
  @override
  // TODO: implement props
  List<Object> get props => [userID];


}