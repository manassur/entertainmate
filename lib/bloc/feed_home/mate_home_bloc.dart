import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'mate_home_event.dart';
import 'mate_home_state.dart';


class MateHomeBloc extends Bloc<MateHomeEvent, MateHomeState>{
  Repository mateHomeRepository;

  MateHomeBloc({ @required this.mateHomeRepository}) : super(null);


  @override
  MateHomeState get initialState => MateHomeInitialState();

  @override
  Stream<MateHomeState> mapEventToState(MateHomeEvent event) async* {
    if (event is FetchMateHomeEvent) {
      yield MateHomeLoadingState();
      try{
        MateHomeModel  mateHome = await mateHomeRepository.fetchHomeFeed();
        // if(mateHome.length>0){
          yield MateHomeLoadedState(mateHome:mateHome, message: "Feeds Updated");
        // }
      }catch(e){
        yield MateHomeFailureState(error: e.toString());
      }
    }


    // if (event is RefreshMateHomeEvent) {
    //   yield MateHomeRefreshingState();
    //   try{
    //     List<Feeds> feeds = await mateHomeRepository.fetchHomeFeed();
    //     yield MateHomeRefreshedState(feeds:feeds,message: "Feeds Updated");
    //   }catch(e){
    //     yield MateHomeFailureState(error: e.toString());
    //   }
    // }
  }

}