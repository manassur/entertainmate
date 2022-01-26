import 'dart:async';

import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/utility/create_event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'publish_event_event.dart';
import 'publish_event_state.dart';


class PublishEventBloc extends Bloc<PublishEventEvent, PublishEventState> {
  Repository repository;
  BuildContext context;
  PublishEventBloc({@required this.repository,this.context}) : super(null);

  @override
  PublishEventState get initialState => PublishEventInitialState();

  @override
  Stream<PublishEventState> mapEventToState(PublishEventEvent event) async* {
    CreateEventProvider _provider = Provider.of<CreateEventProvider>(context, listen: false);

    if (event is PostingEventEvent) {
      yield PublishEventLoadingState();
      try {
             GenericResponse response = await repository.publishEvent(
               _provider.busid,
               _provider.branch,
            _provider.eventType,
            _provider.categoryId,
            _provider.peopleCount,
            _provider.title,
            _provider.description,
            _provider.location,
            _provider.startDate,
            _provider.endDate,
            _provider.audienceId,
            _provider.isLocationShown,
            _provider.isFirstInterestedAdded,
               _provider.images
    );
        if(response.error!=true){
          yield PostedEventState(postId: response.code ); // in this case the code is the id of the event that was just created
        }else{
          yield  PublishEventFailureState(message: response.message );
        }
      } catch (e) {
        print('EVENT NOT POSTING BECAUSE :'+ e.toString());
        yield PublishEventFailureState(message: e.toString());
      }
    }

  }
}
