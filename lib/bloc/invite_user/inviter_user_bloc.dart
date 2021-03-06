import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/invite_user_model.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'invite_user_event.dart';
import 'invite_user_state.dart';


class InviteUserBloc extends Bloc<InviteUserEvent, InviteUserState>{
  Repository inviteUserRepository;

  InviteUserBloc({ @required this.inviteUserRepository}) : super(null);


  @override
  InviteUserState get initialState => InviteUserInitialState();

  @override
  Stream<InviteUserState> mapEventToState(InviteUserEvent event) async* {
    if (event is FetchInviteUserEvent) {
      yield InviteUserLoadingState();
      InviteUserModel inviteUser;
      try{
        if(event.screen.contains('authorized')) {
           inviteUser = await inviteUserRepository
              .fetchAllUsers(event.screen, event.id);
        }else {
           inviteUser = await inviteUserRepository
              .fetchUserFollowings(event.screen, event.id);
        }
        if(inviteUser.followers.isNotEmpty){
          yield InviteUserLoadedState(inviteUser:inviteUser, message: "Users updated");
        }
         else {
           yield InviteUserEmptyState(message: "You do not have any users yet.");
         }
      }catch(e){
        yield InviteUserFailureState(error: e.toString());
      }
    }
  }

}