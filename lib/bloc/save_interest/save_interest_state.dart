import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SaveInterestState extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveInterestInitialState extends SaveInterestState {
  @override
  List<Object> get props => [];
}

class SaveInterestSuccessState extends SaveInterestState {
  @override
  List<Object> get props => [];
}

class SaveSuccessState extends SaveInterestState {
  String action, type;
  String message;
  SaveSuccessState({@required this.action, this.type, this.message});

  @override
  List<Object> get props => [];
}

class InterestSuccessState extends SaveInterestState {
  String action, type;
  String message;
  InterestSuccessState({@required this.action, this.type, this.message});

  @override
  List<Object> get props => [];
}

class InterestFailureState extends SaveInterestState {
  String message;
  InterestFailureState({@required this.message});

  @override
  List<Object> get props => [];
}
class SaveFailureState extends SaveInterestState {
  String message;
  SaveFailureState({@required this.message});

  @override
  List<Object> get props => [];
}

class SaveInterestFailureState extends SaveInterestState {
  final String error;

  SaveInterestFailureState({@required this.error});
  @override
  List<Object> get props => [error];
}
