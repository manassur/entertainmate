import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class FeedDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FeedDetailsInitialState extends FeedDetailsState {
  @override
  List<Object> get props => [];
}

class FeedDetailsLoadingState extends FeedDetailsState {
  @override
  List<Object> get props => [];
}


class FeedDetailsRefreshingState extends FeedDetailsState {
  @override
  List<Object> get props => [];
}

class FeedDetailsLoadedState extends FeedDetailsState {
  FeedDetailsModel feedDetails;
  String message;
  FeedDetailsLoadedState({@required this.feedDetails, this.message});

  @override
  List<Object> get props => [];
}


class FeedDetailsFailureState extends FeedDetailsState {
  final String error;

  FeedDetailsFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
