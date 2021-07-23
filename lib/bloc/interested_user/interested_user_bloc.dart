import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/InterestedUserModel.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'interested_user_event.dart';
import 'interested_user_state.dart';


class InterestedUserBloc extends Bloc<InterestedUserEvent, InterestedUserState>{
  Repository interestedUserRepository;

  InterestedUserBloc({ @required this.interestedUserRepository}) : super(null);


  @override
  InterestedUserState get initialState => InterestedUserInitialState();

  @override
  Stream<InterestedUserState> mapEventToState(InterestedUserEvent event) async* {
    if (event is FetchInterestedUserEvent) {
      yield InterestedUserLoadingState();
      try{
        InterestedUserModel  interestedUser = await interestedUserRepository.fetchInterestedUser();
        // if(userComment.comments.isNotEmpty) {
          yield InterestedUserLoadedState(interestedUser: interestedUser, message: "Feed Details Updated");
        // }
        }catch(e){
        yield InterestedUserFailureState(error: e.toString());
      }
    }

  }

}