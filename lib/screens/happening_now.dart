import 'package:entertainmate/bloc/feed_details/feed_details_bloc.dart';
import 'package:entertainmate/bloc/feed_details/feed_details_event.dart';
import 'package:entertainmate/bloc/feed_details/feed_details_state.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/utility/read_more.dart';
import 'package:entertainmate/widgets/comments_widget.dart';
import 'package:entertainmate/widgets/details_widget.dart';
import 'package:entertainmate/widgets/interested_widget.dart';
import 'package:entertainmate/widgets/people_widget.dart';
import 'package:entertainmate/widgets/photos_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/feed_details_model.dart';

class HappeningNowScreen extends StatefulWidget {
  FeedDetailsModel feedDetailsModel;
  String feedId;

  HappeningNowScreen({Key key, @required this.feedDetailsModel, this.feedId});

  @override
  _HappeningNowScreenState createState() => _HappeningNowScreenState();
}

class _HappeningNowScreenState extends State<HappeningNowScreen> {
  FeedDetailsBloc feedDetailsBloc;
  Repository repository;
  FeedDetailsModel feedDetailsModel = FeedDetailsModel();
  @override
  void initState() {
    super.initState();
    feedDetailsBloc = BlocProvider.of<FeedDetailsBloc>(context);
    feedDetailsBloc.add(FetchFeedDetailsEvent());

  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Happening Now", style: TextStyle( fontSize: 18, color: Colors.grey[600],  fontWeight: FontWeight.bold)),
          leading: InkWell(onTap: () {Navigator.pop(context);},
            child: Container(
              alignment: Alignment.center,
              child: Text("Back", style: TextStyle(color: Colors.grey[900]),),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              onPressed: () {
              },
            ),
          ],
        ),

        body: BlocListener <FeedDetailsBloc, FeedDetailsState>(
          listener: (context, state){
            if ( state is FeedDetailsRefreshingState ) {
              Scaffold.of ( context ).showSnackBar ( SnackBar (
                content: Text ( 'Refreshing' ) , ) );
            } else if ( state is FeedDetailsLoadedState && state.message != null ) {

            } else if ( state is FeedDetailsFailureState ) {
              Scaffold.of ( context ).showSnackBar ( SnackBar (
                content: Text ( "Could not load Feeds at this time" ),
              ) );
            }
          },

          child: BlocBuilder<FeedDetailsBloc, FeedDetailsState>(
            builder: (context, state) {
              if ( state is FeedDetailsInitialState ) {
                return buildLoading ( );
              } else if ( state is FeedDetailsLoadingState ) {
                return buildLoading ( );
              } else if ( state is FeedDetailsLoadedState ) {
                return buildFeedDetails ( state.feedDetails);
              } else if ( state is FeedDetailsFailureState ) {
                return buildErrorUi ( state.error );
              }
              else {
                return buildErrorUi ( "Something went wrong!" );
              }
            },
          ),

        ),

      ),
    );
  }

  Widget buildFeedDetails(FeedDetailsModel feedDetailModel){
    return SingleChildScrollView(
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:0.3),
            child: Container(
                color: Colors.white,
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                      "Indoor soccer",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ))),
          ),

          Padding (
            padding: EdgeInsets.only (top: 10, bottom: 0 ),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height:10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: Colors.grey,),
                      SizedBox(width:20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Today ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              Text("7.00 ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              Text("pm ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              Text("until ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              Text("9.00 ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              Text("pm", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:2.0),
                            child: Text("Thursday, June 4", style: TextStyle(color: Colors.grey[500]),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height:20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Colors.grey,),
                      SizedBox(width:20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ping Rec Center ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                          Padding(
                            padding: const EdgeInsets.only(top:2.0),
                            child: Text("82 S Green Dr. Athens.OH",
                              style: TextStyle(color: Colors.grey[800], fontSize: 15, decoration: TextDecoration.underline ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:2.0),
                            child: Text("In-person event", style: TextStyle(color: Colors.grey[500]),),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height:20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lock_outline, color: Colors.grey,),
                      SizedBox(width:20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Open to the public ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                          Padding(
                            padding: const EdgeInsets.only(top:2.0),
                            child: Text("Looking for 4 people", style: TextStyle(color: Colors.grey[500]),),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height:15),

                  Divider(color: Colors.grey[400],),
                  SizedBox(height:15),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              image:  DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox( width: 10),

                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                        '${feedDetailsModel.feeds[0].name}',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Icon(Icons.stars, color: Colors.blue, size: 17,),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 4.5, 0.0, 0.0),
                                  child: Text("Physical education, M.Sc", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                ),
                                Row(
                                  children: [
                                    Text("5hr ", style: TextStyle(color: Colors.grey),),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                          height: 16,
                                          width: 16,
                                          child: Image.network("https://cdn3.iconfinder.com/data/icons/faticons/32/globe-01-512.png")),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),

                            ),
                          ),

                          SizedBox( width: 10),

                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                ReadMoreText(
                                  "Lorem ipsum dolor sit amet, something for lorem Lorem ipsum dolor sit amet, something Lorem ipsum dolor sit amet, something lorem ipsum dolor omething lorem ipsum dolor omething lorem ipsum dolor",
                                  trimLines: 3,
                                  colorClickableText: Colors.grey.withOpacity(0.9),
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: '...See More',
                                  trimExpandedText: ' See Less',
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),

          DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.grey[200],
                          bottom:  TabBar(
                            unselectedLabelColor: Colors.grey[700],
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Colors.blue,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30), // Creates border
                              color: Colors.lightBlueAccent.shade100.withOpacity(0.2),

                            ),

                            tabs: [
                              Container(
                                // color: Colors.red,
                                width: 85,
                                height: 30,
                                child: Tab(
                                  text: "People",
                                ),
                              ),
                              Container(
                                width: 85,
                                height: 30,
                                child: Tab(
                                  text: "Photos",
                                ),
                              ),
                              Container(
                                width: 85,
                                height: 30,
                                child: Tab(
                                  text: "Details",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right:15.0, left: 15.0),
                      child: Divider(color: Colors.grey[400],),
                    ),

                    SizedBox(height: 10,),


                    SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height, //height of TabBarView

                          child: TabBarView(children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(child: PeopleWidget()),

                                  SizedBox(height: 15),

                                  Expanded(child: InterestedWidget()),

                                  SizedBox(height: 15),

                                  Expanded(child: CommentWidget()),

                                ],
                              ),
                            ),
                            Container(
                              child: PhotosWidget(),
                            ),
                            Container(
                              child:DetailsWidget(),
                            ),
                          ])),
                    )
                  ])),
        ]),
      ),
    );

  }

  Widget buildLoading ( ) {
    return Container(
      margin: EdgeInsets.only(top:50),
      child: Center (
        child: CircularProgressIndicator ( ) ,
      ),
    );
  }

  Widget buildErrorUi ( String message ) {
    return Center (
      child: Text ( message , style: TextStyle ( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );
  }
}
