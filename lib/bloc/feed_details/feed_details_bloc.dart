import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'feed_details_event.dart';
import 'feed_details_state.dart';


class FeedDetailsBloc extends Bloc<FeedDetailsEvent, FeedDetailsState>{
  Repository feedDetailsRepository;

  FeedDetailsBloc({ @required this.feedDetailsRepository}) : super(null);


  @override
  FeedDetailsState get initialState => FeedDetailsInitialState();

  @override
  Stream<FeedDetailsState> mapEventToState(FeedDetailsEvent event) async* {
    if (event is FetchFeedDetailsEvent) {
      yield FeedDetailsLoadingState();
      try{
        FeedDetailsModel  feedDetails = await feedDetailsRepository.fetchFeedDetails();
        if(feedDetails.feeds.isNotEmpty) {
          yield FeedDetailsLoadedState(
              feedDetails: feedDetails, message: "Feed Details Updated");
        }
        }catch(e){
        yield FeedDetailsFailureState(error: e.toString());
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