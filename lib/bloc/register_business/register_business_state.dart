import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RegisterBusinessState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterBusinessInitialState extends RegisterBusinessState {
  @override
  List<Object> get props => [];
}

class RegisterBusinessLoadingState extends RegisterBusinessState {
  @override
  List<Object> get props => [];
}

class RegisteredBusinessState extends RegisterBusinessState {
  @override
  List<Object> get props => [];
}

class RegisterBusinessFailureState extends RegisterBusinessState {
  final String message;

  RegisterBusinessFailureState({@required this.message});

  @override
  List<Object> get props => [];
}
