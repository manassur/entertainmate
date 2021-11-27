import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/model/old_event_model.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'old_event_event.dart';
import 'old_event_state.dart';


class OldEventBloc extends Bloc<OldEventEvent, OldEventState>{
  Repository repository;

  OldEventBloc({ @required this.repository}) : super(null);

  @override
  OldEventState get initialState => OldEventInitialState();

  @override
  Stream<OldEventState> mapEventToState(OldEventEvent event) async* {
    if (event is FetchOldEventEvent) {
      yield OldEventLoadingState();
      try{
        OldEventModel  oldEvent = await repository.fetchOldEvent();
        // if(mateHome.length>0){
          yield OldEventLoadedState(oldEvent:oldEvent, message: "Feeds Updated");
        // }
      }catch(e){
        yield OldEventFailureState(error: e.toString());
      }
    }
  }

}