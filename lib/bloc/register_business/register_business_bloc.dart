import 'dart:async';
import 'package:entertainmate/bloc/register_business/register_business_event.dart';
import 'package:entertainmate/bloc/register_business/register_business_state.dart';
import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterBusinessBloc extends Bloc<RegisterBusinessEvent, RegisterBusinessState> {
  Repository repository;

  RegisterBusinessBloc({@required this.repository}) : super(null);

  @override
  RegisterBusinessState get initialState => RegisterBusinessInitialState();

  @override
  Stream<RegisterBusinessState> mapEventToState(RegisterBusinessEvent event) async* {
    if (event is RegisteringBusinessEvent) {
      yield RegisterBusinessLoadingState();
      try {
        GenericResponse registerBusinessResponse =
        await repository.registerBusiness(event.name, event.type, event.description, event.slogan, event.phone, event.email, event.location, event.time, event.website, event.more);
        if(registerBusinessResponse.error!=true){
          yield RegisteredBusinessState( );
        }else{
          yield  RegisterBusinessFailureState(message: registerBusinessResponse.message );
        }
      } catch (e) {
        yield RegisterBusinessFailureState(message: e.toString());
      }
    }

  }
}
