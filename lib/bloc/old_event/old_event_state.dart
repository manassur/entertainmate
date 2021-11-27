import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/model/old_event_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class OldEventState extends Equatable {
  @override
  List<Object> get props => [];
}

class OldEventInitialState extends OldEventState {
  @override
  List<Object> get props => [];
}

class OldEventLoadingState extends OldEventState {
  @override
  List<Object> get props => [];
}


class OldEventRefreshingState extends OldEventState {
  @override
  List<Object> get props => [];
}

class OldEventLoadedState extends OldEventState {
  OldEventModel oldEvent;
  String message;
  OldEventLoadedState({@required this.oldEvent, this.message});

  @override
  List<Object> get props => [];
}


class OldEventFailureState extends OldEventState {
  final String error;

  OldEventFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
