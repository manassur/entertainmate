import 'package:entertainmate/screens/model/InterestedUserModel.dart';
import 'package:equatable/equatable.dart';

abstract class InterestedUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInterestedUserEvent extends InterestedUserEvent {
  List<InterestedUserModel> interestedUser;
  // final String postId;
  // FetchInterestedUserEvent({ @required this.postId});

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


