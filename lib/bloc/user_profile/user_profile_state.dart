import 'package:entertainmate/screens/model/user_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserProfileInitialState extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileLoadingState extends UserProfileState {
  @override
  List<Object> get props => [];
}


class UserProfileLoadedState extends UserProfileState {
  UserProfileModel userProfile;
  String message;
  UserProfileLoadedState({@required this.userProfile, this.message});

  @override
  List<Object> get props => [];
}


class UserProfileFailureState extends UserProfileState {
  final String error;

  UserProfileFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
