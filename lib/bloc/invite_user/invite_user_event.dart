import 'package:equatable/equatable.dart';

abstract class InviteUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInviteUserEvent extends InviteUserEvent {
  String screen, id;

  FetchInviteUserEvent({this.screen, this.id});

  @override
  List<Object> get props => [];
}




