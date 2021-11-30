import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/businessModel.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'user_business_event.dart';
import 'user_business_state.dart';


class UserBusinessBloc extends Bloc<UserBusinessEvent, UserBusinessState>{
  Repository repository;

  UserBusinessBloc({ @required this.repository}) : super(null);


  @override
  UserBusinessState get initialState => UserBusinessInitialState();

  @override
  Stream<UserBusinessState> mapEventToState(UserBusinessEvent event) async* {
    if (event is FetchUserBusinessEvent) {
      yield UserBusinessLoadingState();
      try{
        BusinessModel  businessModel = await repository.fetchUserBusiness();
        if(businessModel.business.isNotEmpty) {
          yield UserBusinessLoadedState(businessModel: businessModel, message: "user business Updated");
        } else{
          yield UserBusinessEmptyState(message: "this user has no business");
        }
        }catch(e){
        yield UserBusinessFailureState(error: e.toString());
      }
    }

  }

}