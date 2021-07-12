import 'package:entertainmate/screens/model/post_comment_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PublishEventState extends Equatable {
  @override
  List<Object> get props => [];
}

class PublishEventInitialState extends PublishEventState {
  @override
  List<Object> get props => [];
}

class PublishEventLoadingState extends PublishEventState {
  @override
  List<Object> get props => [];
}

class PostedEventState extends PublishEventState {
  String postId;
  PostedEventState({@required this.postId});
  @override
  List<Object> get props => [];
}

class PublishEventFailureState extends PublishEventState {
  final String message;

  PublishEventFailureState({@required this.message});

  @override
  List<Object> get props => [];
}
