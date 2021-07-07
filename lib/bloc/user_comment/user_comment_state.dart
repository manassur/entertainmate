import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserCommentState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserCommentInitialState extends UserCommentState {
  @override
  List<Object> get props => [];
}

class UserCommentLoadingState extends UserCommentState {
  @override
  List<Object> get props => [];
}


class UserCommentRefreshingState extends UserCommentState {
  @override
  List<Object> get props => [];
}

class UserCommentLoadedState extends UserCommentState {
  UserCommentModel userComment;
  String message;
  UserCommentLoadedState({@required this.userComment, this.message});

  @override
  List<Object> get props => [];
}


class UserCommentFailureState extends UserCommentState {
  final String error;

  UserCommentFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
