import 'package:entertainmate/screens/model/businessModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserBusinessState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserBusinessInitialState extends UserBusinessState {
  @override
  List<Object> get props => [];
}

class UserBusinessLoadingState extends UserBusinessState {
  @override
  List<Object> get props => [];
}

class UserBusinessLoadedState extends UserBusinessState {
  BusinessModel businessModel;
  String message;
  UserBusinessLoadedState({@required this.businessModel, this.message});

  @override
  List<Object> get props => [];
} 


class UserBusinessFailureState extends UserBusinessState {
  final String error;

  UserBusinessFailureState({@required this.error});

  @override
  List<Object> get props => [error];
}


class UserBusinessEmptyState extends UserBusinessState{
  final String message;
  UserBusinessEmptyState({@required this.message});

  @override
  List<Object> get props => [];
}