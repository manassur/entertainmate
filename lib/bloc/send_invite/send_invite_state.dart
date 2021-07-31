import 'package:entertainmate/screens/model/post_comment_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PostCommentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostCommentInitialState extends PostCommentState {
  @override
  List<Object> get props => [];
}

class PostCommentLoadingState extends PostCommentState {
  @override
  List<Object> get props => [];
}

class PostedCommentState extends PostCommentState {
  String postId;
  PostedCommentState({@required this.postId});
  @override
  List<Object> get props => [];
}

class PostCommentFailureState extends PostCommentState {
  final String message;

  PostCommentFailureState({@required this.message});

  @override
  List<Object> get props => [];
}
