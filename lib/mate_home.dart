import 'package:entertainmate/screens/create_event.dart';
import 'package:entertainmate/screens/filter_screen.dart';
import 'package:entertainmate/screens/happening_now.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/neighborhood_screen.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/utility/read_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/feed_details/feed_details_bloc.dart';
import 'bloc/feed_home/mate_home_bloc.dart';
import 'bloc/feed_home/mate_home_event.dart';
import 'bloc/feed_home/mate_home_state.dart';

class MateHome extends StatefulWidget {
  @override
  _MateHomeState createState() => _MateHomeState();
}

class _MateHomeState extends State<MateHome> {
  MateHomeBloc mateHomeBloc;
  Repository homeMateRepository;
  Repository feedDetailsRepository;
  MateHomeModel homeMateModel;
  FeedDetailsModel feedDetailsModel;
  // RefreshController refreshController;

  bool isRefreshing=false;

  setRefreshing(bool state){
    setState(() {
      isRefreshing = state;
    });
    if(state==false){
      // _refreshController.refreshCompleted();
    }

  }
  // RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState(){
    super.initState();
    mateHomeBloc = BlocProvider.of<MateHomeBloc>(context);
    mateHomeBloc.add(FetchMateHomeEvent());
  }

  void refresh(){
    setState(() {
      isRefreshing =true;
    });

    mateHomeBloc.add(RefreshMateHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title:  RichText(
          text: TextSpan(
              text: 'Entertain',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20,fontWeight: FontWeight.w700),
              children: <TextSpan>[
                TextSpan(text: 'Mate',
                  style: TextStyle(
                      color: Colors.blueAccent, fontSize: 20,fontWeight: FontWeight.w700),

                )
              ]
          ),),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEvent()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
          )
        ],
      ) ,

      body: Column(
        children: [
          Container(
            color: Colors.white10,
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.timer,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NeighborhoodScreen()));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.navigation_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Athens,OH',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.filter_list,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //feeds list
     BlocListener <MateHomeBloc, MateHomeState>(
              listener: (context, state){
                if ( state is MateHomeRefreshingState ) {
                  Scaffold.of ( context ).showSnackBar ( SnackBar (
                    content: Text ( 'Refreshing' ) , ) );
                } else if ( state is MateHomeLoadedState && state.message != null ) {

                }else if ( state is MateHomeCachedLoadedState  ) {
                  // a message will only come when it is updating the feed.
                }
                else if ( state is MateHomeFailureState ) {
                  Scaffold.of ( context ).showSnackBar ( SnackBar (
                    content: Text ( "Could not load Feeds at this time" ),
                    ) );
                }
              },

              child: BlocBuilder<MateHomeBloc, MateHomeState>(
                builder: (context, state) {
                  if ( state is MateHomeInitialState ) {
                    return buildLoading ( );
                  } else if ( state is MateHomeLoadingState ) {
                    return buildLoading ( );
                  } else if ( state is MateHomeLoadedState ) {
                    return buildHomeFeedList ( state.mateHome);
                  } else if ( state is MateHomeFailureState ) {
                    return buildErrorUi ( state.error );
                  }
                  else {
                    return buildErrorUi ( "Something went wrong!" );
                  }
                },
              ),

          ),

        ],
      ),
    );
  }

  Widget buildHomeFeedList (MateHomeModel mateHomeModel){
    return  Padding (
      padding: EdgeInsets.symmetric (vertical: 10 ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              BlocProvider<FeedDetailsBloc>(
              create: (context) => FeedDetailsBloc(feedDetailsRepository: Repository()),
              child: HappeningNowScreen(postId: mateHomeModel.feeds[0].post.postId,)
          )
          ));
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      image:  DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
                        // image: NetworkImage('${mateHomeModel.feeds[0].profilePhoto}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox( width: 20),

                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          // ${latestNewsModel[pos].xFeaturedMedia},
                            '${mateHomeModel.feeds[0].username}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 4.5, 0.0, 0.0),
                          child: Text(
                              '${mateHomeModel.feeds[0].description}',
                            style: TextStyle(fontSize: 16, color: Colors.grey),),
                        ),
                        Row(
                          children: [
                            Text("5hr ", style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child: Container(
                                  height: 16,
                                  width: 16,
                                  child: Image.network(
                                      "https://cdn3.iconfinder.com/data/icons/faticons/32/globe-01-512.png"
                                  )),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                  Text("Interested ", style: TextStyle(fontSize: 16, color: Colors.black87),),

                ],
              ),

              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),

                    ),
                  ),

                  SizedBox( width: 20),

                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text("7:00 ", style: TextStyle(fontSize: 16),),
                            Text("pm", style: TextStyle(fontSize: 16),),
                            Text(" until ", style: TextStyle(fontSize: 16),),
                            Text("9:00 ", style: TextStyle(fontSize: 16),),
                            Text("pm", style: TextStyle(fontSize: 16),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
                          child: Text(
                            "${mateHomeModel.feeds[0].post.content}",
                            style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),),
                        ),
                        Column(
                          children: [
                            ReadMoreText(
                              // "Lorem ipsum dolor sit amet, something for lorem Lorem ipsum dolor sit amet, something Lorem ipsum dolor sit amet, something lorem ipsum dolor omething lorem ipsum dolor omething lorem ipsum dolor",
                              "${mateHomeModel.feeds[0].post.description}",
                              trimLines: 3,
                              colorClickableText: Colors.grey.withOpacity(0.9),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...See More',
                              trimExpandedText: ' See Less',

                              style: TextStyle(fontSize: 17, color: Colors.black87),
                            ),
                          ],
                        ),

                        Divider(color: Colors.grey),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: <Widget>[
                                new Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image:  DecorationImage(
                                      image: NetworkImage('https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image:  DecorationImage(
                                        image: NetworkImage('https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg?size=626&ext=jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(width: 20),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Open to the ", style: TextStyle(fontSize: 17, color: Colors.black87),),
                                    Text(
                                      "${mateHomeModel.feeds[0].post.audience}",
                                      style: TextStyle(fontSize: 17, color: Colors.black87),),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                                  child: Row(
                                    children: [
                                      Text("Occupied seats: ", style: TextStyle(color: Colors.grey, fontSize: 17),),
                                      Text(
                                        "${mateHomeModel.feeds[0].post.occupiedSeats}",
                                        style: TextStyle(color: Colors.grey, fontSize: 17),)
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Available seats: ", style: TextStyle(color: Colors.grey, fontSize: 17),),
                                    Text(
                                      "${mateHomeModel.feeds[0].post.availableSeats}",
                                      style: TextStyle(color: Colors.grey, fontSize: 17),),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),

                        Divider(color: Colors.grey),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.save_alt_rounded),
                                Text(
                                    "${mateHomeModel.feeds[0].post.saves}",
                                    style: TextStyle(fontSize: 17, color: Colors.black87)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.add_outlined),
                                Text(
                                    "${mateHomeModel.feeds[0].post.going}",
                                    style: TextStyle(fontSize: 17, color: Colors.black87)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.mode_comment_outlined),
                                Text(
                                    "${mateHomeModel.feeds[0].post.comments}",
                                    style: TextStyle(fontSize: 17, color: Colors.black87)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined),
                                Text(
                                    "${mateHomeModel.feeds[0].post.interests}",
                                    style: TextStyle(fontSize: 17, color: Colors.black87)),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
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
