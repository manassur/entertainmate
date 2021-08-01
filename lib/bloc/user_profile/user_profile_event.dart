import 'package:entertainmate/screens/model/user_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserProfileEvent extends UserProfileEvent {
  UserProfileModel userProfile;
  final String userId;
  FetchUserProfileEvent({ @required this.userId});
  @override
  List<Object> get props => [];
}





