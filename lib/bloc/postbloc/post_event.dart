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

class GetPost extends PostEvent {
  @override
  List<Object> get props => null;
}

class Refresh extends PostEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetMorePost extends PostEvent {
  @override
  List<Object> get props => null;
}

class GetNewPost extends PostEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetMoreNewPost extends PostEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetWeekPost extends PostEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class GetMoreWeek extends PostEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class LikePost extends PostEvent {
  final String userID;
  final String postID;
  final String ownerUserID;

  LikePost({this.postID, this.userID, this.ownerUserID});

  @override
  List<Object> get props => throw UnimplementedError();
}

class GetUserPopulars extends PostEvent {
  final String userID;

  GetUserPopulars(this.userID);

  @override
  List<Object> get props => [userID];
}
