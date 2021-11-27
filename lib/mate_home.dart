import 'package:entertainmate/bloc/old_event/old_event_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/publish_event/publish_event_bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_bloc.dart';
import 'package:entertainmate/screens/create_event.dart';
import 'package:entertainmate/screens/filter_screen.dart';
import 'package:entertainmate/screens/happening_now.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/neighborhood_screen.dart';
import 'package:entertainmate/screens/renew_old_event.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/user_profile.dart';
import 'package:entertainmate/screens/utility/read_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/feed_details/feed_details_bloc.dart';
import 'bloc/feed_home/mate_home_bloc.dart';
import 'bloc/feed_home/mate_home_event.dart';
import 'bloc/feed_home/mate_home_state.dart';
import 'bloc/invite_user/inviter_user_bloc.dart';
import 'bloc/user_profile/user_profile_bloc.dart';
import 'screens/mate_notification.dart';
import 'screens/profile_main.dart';
import 'screens/utility/complete_profile_provider.dart';
import 'screens/utility/constants.dart' as Constants;

class MateHome extends StatefulWidget {
  @override
  _MateHomeState createState() => _MateHomeState();
}

class _MateHomeState extends State<MateHome> {
  MateHomeBloc mateHomeBloc;
  Repository homeMateRepository;
  Repository feedDetailsRepository;
  Repository repository;
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
    return Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
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
                    Icons.calendar_today_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // do something
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  BlocProvider<PublishEventBloc>(
                      create: (context) =>
                          PublishEventBloc(repository: Repository(),context:context),
                      child: CreateEvent(),
                    ),));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  MateNotification()));
                  },
                ),
                IconButton(

                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {

                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileMain()));
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(data.profilePhoto),
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                ),

              ],
            )
          ],
        ) ,

        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom:10,top:10),
              color: Colors.white,
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                        color:Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Row(
                        children: [

                          Text(
                            'This week',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NeighborhoodScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),

                        decoration: BoxDecoration(
                            color:Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: Row(
                          children: [

                            Text(
                              'Athens,OH',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),

                        decoration: BoxDecoration(
                            color:Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300)
                        ),
                        child: Row(
                          children: [

                            Text(
                              'Filter',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(0.7),
          child: Icon(Icons.add),
          onPressed: (){
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Wrap(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top:35.0),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.topCenter,
                          width: 100,
                          decoration: BoxDecoration(

                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow (
                                  color: Colors.black54.withOpacity (
                                      0.2 ),
                                  blurRadius: 8.0,
                                ),]
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                    ),
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return FractionallySizedBox(
                                        heightFactor: 0.7,
                                          child: CreateEvent());
                                    },
                                  );
                                },
                                  child: Container(child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Create new event", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)),
                                    ],
                                  ))),
                              Divider(),
                              InkWell(
                                  onTap:(){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=>

                                            BlocProvider<OldEventBloc>(
                                            create: (context) => OldEventBloc(repository: Repository()),
                                            child:RenewOldEventScreen()

                                            ),

                                        ));
                                  } ,
                                  child: Text("Renew an old event", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:5),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.topCenter,
                          width: 100,
                          decoration: BoxDecoration(

                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow (
                                  color: Colors.black54.withOpacity (
                                      0.2 ),
                                  blurRadius: 8.0,
                                ),]
                          ),
                          child: Column(
                            children: [
                              Text("Cancel", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)),
                             ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:20),
                  ],
                );
              },
            );

          },
        ),
      );});

  }

  Widget buildHomeFeedList (MateHomeModel mateHomeModel){
   return Expanded(
     child: ListView.builder(
        itemCount: mateHomeModel.feeds.length,
        itemBuilder: (context,pos){
          return  Padding (
            padding: EdgeInsets.symmetric (vertical: 5 ),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    MultiBlocProvider(
                        providers:[
                          BlocProvider<FeedDetailsBloc>(
                            create: (context) =>
                                FeedDetailsBloc(feedDetailsRepository: Repository()),
                          ),

                          BlocProvider<SaveInterestBloc>(
                            create: (context) =>
                                SaveInterestBloc(saveInterestRepository: Repository()),
                          ),

                          BlocProvider<PostCommentBloc>(
                            create: (context) =>
                                PostCommentBloc(postCommentRepository: Repository()),
                          ),

                          BlocProvider<InviteUserBloc>(
                            create: (context) =>
                                InviteUserBloc(inviteUserRepository: Repository()),
                          ),

                        ],
                        child: HappeningNowScreen(postId: mateHomeModel.feeds[pos].post.postId,)
                    ),
                )
                );
              },

              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 10.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  BlocProvider<UserProfileBloc>(
                              create: (context) =>
                                  UserProfileBloc(userProfileRepository: Repository()),
                              child: BlocProvider<PostCommentBloc>(
                                create: (context) =>
                                    PostCommentBloc(postCommentRepository: Repository()),
                                child: UserProfile(userId: mateHomeModel.feeds[pos].userId),
                              ),) ,
                            ),);
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              image:  DecorationImage(
                                image: NetworkImage(
                                    Constants.IMAGE_BASE_URL+'${ mateHomeModel.feeds[pos].profilePhoto}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        SizedBox( width: 15),

                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  '${mateHomeModel.feeds[pos].username}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 4.5, 0.0, 0.0),
                                child: Text(
                                  '${mateHomeModel.feeds[pos].description}',
                                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),),
                              ),
                              Row(
                                children: [
                                  Text("5hr ", style: TextStyle(color: Colors.grey.shade600),),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                        height: 16,
                                        width: 16,
                                        child: Image.network(
                                            "https://cdn3.iconfinder.com/data/icons/faticons/32/globe-01-512.png", color: Colors.grey.shade500,
                                        )),
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 15,),
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

                        SizedBox( width: 15),

                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text("Today, ", style: TextStyle(fontSize: 16),),
                                  Text("7:00 ", style: TextStyle(fontSize: 16),),
                                  Text("pm", style: TextStyle(fontSize: 16),),
                                  Text(" - ", style: TextStyle(fontSize: 16),),
                                  Text("9:00 ", style: TextStyle(fontSize: 16),),
                                  Text("pm", style: TextStyle(fontSize: 16),),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
                                child: Text(
                                  "${mateHomeModel.feeds[pos].post.content}",
                                  style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),),
                              ),
                              Column(
                                children: [
                                  ReadMoreText(
                                    // "Lorem ipsum dolor sit amet, something for lorem Lorem ipsum dolor sit amet, something Lorem ipsum dolor sit amet, something lorem ipsum dolor omething lorem ipsum dolor omething lorem ipsum dolor",
                                    "${mateHomeModel.feeds[pos].post.description}",
                                    trimLines: 3,
                                    colorClickableText: Colors.grey.withOpacity(0.9),
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '...See More',
                                    trimExpandedText: ' See Less',

                                    style: TextStyle(fontSize: 17, color: Colors.black87),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),

                              Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage("images/entertainmate_pics.jpeg"),
                                    fit: BoxFit.cover,
                                  )
                                ),
                              ),


                              SizedBox(height: 10),

                              Divider(color: Colors.grey),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Reactions ", style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                                      Text("${mateHomeModel.feeds[pos].post.saves}",
                                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                                    ],
                                  ),
                                  Spacer(),

                                  Row(
                                    children: [
                                      Text(
                                          "${mateHomeModel.feeds[pos].post.comments}",
                                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),

                                      Text(" Comments", style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                                       ],
                                  ),
                                  
                                  SizedBox(width: 10.0,),
                                  
                                  Row(
                                    children: [
                                      Text(
                                          "${mateHomeModel.feeds[pos].post.interests}",
                                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                                      Text(" Shares", style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),

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
        },
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
