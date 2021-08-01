import 'package:entertainmate/screens/model/InterestedUserModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class InterestedUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInterestedUserEvent extends InterestedUserEvent {
  List<InterestedUserModel> interestedUser;
  final String userId;
  FetchInterestedUserEvent({@required this.userId});

  @override
  List<Object> get props => [];
}


// class RefreshUserCommentEvent extends InterestedUserEvent {
//   @override
//   List<Object> get props => [];
// }
//
// class FetchCachedUserCommentEvent extends InterestedUserEvent {
//   @override
//   List<Object> get props => [];
// }


