import 'dart:io';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PostCommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostingCommentEvent extends PostCommentEvent {
  String comment;
  String postId;
  PostingCommentEvent({@required this.comment, this.postId});
  @override
  List<Object> get props => [];
}

class FollowEvent extends PostCommentEvent {
  String userId;
  int action;
  FollowEvent({ this.userId,this.action});
  @override
  List<Object> get props => [];
}
