import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FeedDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFeedDetailsEvent extends FeedDetailsEvent {
  List<FeedDetailsModel> feedDetails;
  final String postId;
  final int branch;
  FetchFeedDetailsEvent({ @required this.postId,this.branch});
  @override
  List<Object> get props => [];
}

class FetchPostsByTypeAndCategoryEvent extends FeedDetailsEvent {
  List<FeedDetailsModel> feedDetails;
  final String type,category;
  final int branch;
  FetchPostsByTypeAndCategoryEvent({ @required this.branch,this.type,this.category});
  @override
  List<Object> get props => [];
}
class RefreshFeedDetailsEvent extends FeedDetailsEvent {
  @override
  List<Object> get props => [];
}

class FetchCachedFeedDetailsEvent extends FeedDetailsEvent {
  @override
  List<Object> get props => [];
}


