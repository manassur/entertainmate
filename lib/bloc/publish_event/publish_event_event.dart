import 'dart:io';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PublishEventEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostingEventEvent extends PublishEventEvent {
  String comment;
  String postId;
  PostingEventEvent({@required this.comment, this.postId});
  @override
  List<Object> get props => [];
}
