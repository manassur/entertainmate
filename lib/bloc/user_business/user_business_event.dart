import 'package:equatable/equatable.dart';

abstract class UserBusinessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserBusinessEvent extends UserBusinessEvent {
String status;

FetchUserBusinessEvent({this.status});
  @override
  List<Object> get props => [];
}




