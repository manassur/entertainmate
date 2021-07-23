import 'package:entertainmate/screens/model/InterestedUserModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class InterestedUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class InterestedUserInitialState extends InterestedUserState {
  @override
  List<Object> get props => [];
}

class InterestedUserLoadingState extends InterestedUserState {
  @override
  List<Object> get props => [];
}

class InterestedUserLoadedState extends InterestedUserState {
  InterestedUserModel interestedUser;
  String message;
  InterestedUserLoadedState({@required this.interestedUser, this.message});

  @override
  List<Object> get props => [];
}


class InterestedUserFailureState extends InterestedUserState {
  final String error;

  InterestedUserFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
