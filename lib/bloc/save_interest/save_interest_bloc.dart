import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_event.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_state.dart';
import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';


class SaveInterestBloc extends Bloc<SaveInterestEvent, SaveInterestState>{
  Repository saveInterestRepository;

  SaveInterestBloc({ @required this.saveInterestRepository}) : super(null);

  SaveInterestState get initialState => SaveInterestInitialState();

  @override
  Stream<SaveInterestState> mapEventToState(SaveInterestEvent event) async* {
    if (event is FetchSaveEvent) {
      try{
       GenericResponse saveResponse =  await saveInterestRepository.saveInterest(event.action, event.postId, event.type);
         if (saveResponse.error == false) {
           yield SaveSuccessState(message: saveResponse.message);
         }
         else yield SaveFailureState(message: saveResponse.message);
      }catch(e){
        yield SaveInterestFailureState(error: e.toString());
      }
    }else if (event is UpdateLikeEvent) {
      try{
        GenericResponse saveResponse =  await saveInterestRepository.saveInterestAdmin(event.action, event.postId, event.type,event.userId);
        if (saveResponse.error == false) {
          yield SaveSuccessState(message: saveResponse.message);
        }
        else yield SaveFailureState(message: saveResponse.message);
      }catch(e){
        yield SaveInterestFailureState(error: e.toString());
      }
    }


   else if (event is FetchInterestEvent) {
      try{
        GenericResponse interestResponse =   await saveInterestRepository.saveInterest(event.action, event.postId, event.type);
        if (interestResponse.error == false) {
          yield InterestSuccessState( message: interestResponse.message);
        }
        else yield InterestFailureState(message: interestResponse.message);
      }catch(e){
        yield SaveInterestFailureState(error: e.toString());
      }
    }
  }

}