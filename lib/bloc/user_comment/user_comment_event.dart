import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserCommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserCommentEvent extends UserCommentEvent {
  List<UserCommentModel> userComment;
  final String postId;
  FetchUserCommentEvent({ @required this.postId});

  @override
  List<Object> get props => [];
}


class RefreshUserCommentEvent extends UserCommentEvent {
  @override
  List<Object> get props => [];
}

class FetchCachedUserCommentEvent extends UserCommentEvent {
  @override
  List<Object> get props => [];
}


