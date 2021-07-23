import 'package:entertainmate/screens/model/invite_user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class InviteUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class InviteUserInitialState extends InviteUserState {
  @override
  List<Object> get props => [];
}

class InviteUserLoadingState extends InviteUserState {
  @override
  List<Object> get props => [];
}


class InviteUserRefreshingState extends InviteUserState {
  @override
  List<Object> get props => [];
}

class InviteUserLoadedState extends InviteUserState {
  InviteUserModel inviteUser;
  String message;
  InviteUserLoadedState({@required this.inviteUser, this.message});

  @override
  List<Object> get props => [];
}


class InviteUserFailureState extends InviteUserState {
  final String error;

  InviteUserFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}
