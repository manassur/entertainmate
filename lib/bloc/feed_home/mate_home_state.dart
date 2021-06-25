import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class MateHomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class MateHomeInitialState extends MateHomeState {
  @override
  List<Object> get props => [];
}

class MateHomeLoadingState extends MateHomeState {
  @override
  List<Object> get props => [];
}


class MateHomeRefreshingState extends MateHomeState {
  @override
  List<Object> get props => [];
}

class MateHomeLoadedState extends MateHomeState {
  MateHomeModel mateHome;
  String message;
  MateHomeLoadedState({@required this.mateHome, this.message});

  @override
  List<Object> get props => [];
}

class MateHomeCachedLoadedState extends MateHomeState {
  List<Feeds> cachedFeeds;
  String message;
  MateHomeCachedLoadedState({@required this.cachedFeeds, this.message});

  @override
  List<Object> get props => [];
}

class MateHomeRefreshedState extends MateHomeState {
  List<Feeds> feeds;
  String message;
  MateHomeRefreshedState({@required this.feeds, this.message});

  @override
  List<Object> get props => [];
}

class MateHomeFailureState extends MateHomeState {
  final String error;

  MateHomeFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
