import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SaveInterestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchSaveEvent extends SaveInterestEvent {
  final String postId;
  final String action;
  final String type;
  FetchSaveEvent({ @required this.postId, this.type, this.action});

  @override
  List<Object> get props => [];
}

class FetchInterestEvent extends SaveInterestEvent {
  final String postId;
  final String action;
  final String type;
  FetchInterestEvent({ @required this.postId, this.type, this.action});

  @override
  List<Object> get props => [];
}

