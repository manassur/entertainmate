import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/model/user_profile_model.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'user_profile_event.dart';
import 'user_profile_state.dart';


class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState>{
  Repository userProfileRepository;

  UserProfileBloc({ @required this.userProfileRepository}) : super(null);


  @override
  UserProfileState get initialState => UserProfileInitialState();

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is FetchUserProfileEvent) {
      yield UserProfileLoadingState();
      try{
        UserProfileModel  userProfile = await userProfileRepository.fetchUserProfile(event.userId);
          yield UserProfileLoadedState(
              userProfile: userProfile, message: "User Profile Updated");

        }catch(e){
        yield UserProfileFailureState(error: e.toString());
      }
    }
  }

}