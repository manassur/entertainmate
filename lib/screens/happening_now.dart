import 'package:entertainmate/bloc/feed_details/feed_details_bloc.dart';
import 'package:entertainmate/bloc/feed_details/feed_details_event.dart';
import 'package:entertainmate/bloc/feed_details/feed_details_state.dart';
import 'package:entertainmate/bloc/interested_user/interested_user_bloc.dart';
import 'package:entertainmate/bloc/invite_user/inviter_user_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_event.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_state.dart';
import 'package:entertainmate/bloc/user_comment/user_comment_bloc.dart';
import 'package:entertainmate/screens/interested_user_screen.dart';
import 'package:entertainmate/screens/model/post_comment_model.dart';
import 'package:entertainmate/screens/post_comment_screen.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/utility/read_more.dart';
import 'package:entertainmate/widgets/commenters_info_dialog.dart';
import 'package:entertainmate/widgets/photos_widget.dart';
import 'package:entertainmate/widgets/report_incident_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'invite_screen.dart';
import 'model/feed_details_model.dart';
import 'utility/constants.dart' as Constants;
import 'package:timeago/timeago.dart' as timeago;


class HappeningNowScreen extends StatefulWidget {
  FeedDetailsModel feedDetailsModel;
  String postId;
  String action;
  String type;
  String name;
  PostCommentModel postCommentModel;

  HappeningNowScreen({Key key, this.name, @required this.postCommentModel, this.feedDetailsModel, this.postId, this.action, this.type});

  @override
  _HappeningNowScreenState createState() => _HappeningNowScreenState();
}

class _HappeningNowScreenState extends State<HappeningNowScreen> {
  FeedDetailsBloc feedDetailsBloc;
  SaveInterestBloc saveInterestBloc;
  FeedDetailsModel feedDetailsModel;
  Repository repository;
  bool isSaved=false;
  PostCommentBloc postCommentBloc;
  TextEditingController commentController = TextEditingController();
  var audienceList=<String>[
    'Open to public',
    'Invited guests only',

  ];
  var classList=<String>[
    'Non - anonymous',
    'Anonymous',

  ];
  var typeList=<String>[
    'In-person',
    'Online',

  ];
  String dropdownValue ='Category';
  var categoryList=<String>[
    'Category',
    'Social',
    'Sports',
    'Arts',
    'Nature'
  ];
  @override
  void initState() {
    super.initState();
    feedDetailsBloc = BlocProvider.of<FeedDetailsBloc>(context);
    feedDetailsBloc.add(FetchFeedDetailsEvent(postId: widget.postId));

    saveInterestBloc = BlocProvider.of<SaveInterestBloc>(context);
    postCommentBloc = BlocProvider.of<PostCommentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.name,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios,color:Colors.black)
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            onPressed: () {
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
                                              child: ReportIncidentWidget());
                                        },
                                      );
                                    },
                                    child: Container(child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Report an incident", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)),
                                      ],
                                    ))),
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
                                    color: Colors.black54.withOpacity (0.2 ),
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
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocListener<FeedDetailsBloc, FeedDetailsState>(
              listener: (context, state) {
                if (state is FeedDetailsRefreshingState) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Refreshing'),
                  ));
                } else if (state is FeedDetailsLoadedState &&
                    state.message != null) {
                  setState(() {
                    feedDetailsModel = state.feedDetails;
                  });
                } else if (state is FeedDetailsFailureState) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Could not load Feeds at this time"),
                  ));
                }
              },
              child: BlocBuilder<FeedDetailsBloc, FeedDetailsState>(
                builder: (context, state) {
                  if (state is FeedDetailsInitialState) {
                    return buildLoading();
                  } else if (state is FeedDetailsLoadingState) {
                    return buildLoading();
                  } else if (state is FeedDetailsLoadedState) {
                    return buildFeedDetails(state.feedDetails);
                  } else if (state is FeedDetailsFailureState) {
                    return buildErrorUi(state.error);
                  } else {
                    return buildErrorUi("Something went wrong!");
                  }
                },
              ),
            ),
          ),

          SizedBox(height: 0),

          //the bottom bar
          BlocListener<SaveInterestBloc, SaveInterestState>(
            listener: (content, state){
              if (state is SaveSuccessState) {
                // Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                print("flutter toast save post happened " + state.message);
              }
              else if (state is SaveFailureState) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
              else if (state is InterestSuccessState) {
                Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
              else if (state is InterestFailureState) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)));
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
            width: MediaQuery.of(context).size.width,
              height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),

                ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.grey[300],
                    ),
                    child:Icon(Icons.share),
                  ),
                  SizedBox(width:10),
                  InkWell(
                    onTap: (){
                      saveInterestBloc.add(FetchSaveEvent(postId: "1", type: "1", action: "1"));
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.grey[300],
                        ),
                        child: Icon( Icons.save_alt_rounded )
                    ),
                  ),

                  // show invite Users modal
                  Spacer(),

                  InkWell(
                    onTap: (){
                      saveInterestBloc.add(FetchInterestEvent(postId: feedDetailsModel.feeds[0].post.postId, type: "1", action: "1"));
                    },
                    child: Container(
                        height: 50,
                        width: 135,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Interested",style:TextStyle(fontWeight:FontWeight.w600)),
                            SizedBox(width:5),
                            Icon(Icons.thumb_up_alt_outlined),
                          ],
                        ),),
                  ),
                  SizedBox(height: 5),
                ],
              )
            ),
          )
        ],
      ),
    );
  }

  Widget buildFeedDetails(FeedDetailsModel feedDetailsModel) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Container(
            color:Colors.grey[200],
            padding: EdgeInsets.only(top:10,bottom:10),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left:10),
                      child: Container(
                          color: Colors.transparent,
                          child: Center(
                              child: Text(
                            feedDetailsModel.feeds[0].post.categoryName,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ))),
                    ),
                  ],
                ),
                Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.3,left:10),
                      child: Container(
                          color: Colors.transparent,
                          child: Center(
                              child: Text(
                                '${DateFormat('dd-MM-yyyy').format(DateTime.parse(feedDetailsModel.feeds[0].post.startDate))} ${DateFormat('HH:mma').format(DateTime.parse(feedDetailsModel.feeds[0].post.startDate))} - ${DateFormat('HH:mma').format(DateTime.parse(feedDetailsModel.feeds[0].post.endDate))}',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.redAccent),
                              ))),
                    ),
                  ],
                ),
              ],
            ),
          ),


          DefaultTabController(
              length: 4,
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          bottom: TabBar(
                            unselectedLabelColor: Colors.grey[700],
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Colors.blue,

                            tabs: [
                              Tab(
                                text: "Details",
                              ),
                              Tab(
                                text: "People",
                              ),
                              Tab(
                                text: "Comments",
                              ),
                              Tab(
                                text: "Media",
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    SingleChildScrollView(
                      child: Container(
                          height: 470, //height of TabBarView SOEMTHING HAS TO BE DONE
                          //ABOUT THIS STATIC HEIGHT FOR THE TABBAR

                          child: TabBarView(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 0),
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
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${DateFormat('HH:mma').format(DateTime.parse(feedDetailsModel.feeds[0].post.startDate))} - ${DateFormat('HH:mma').format(DateTime.parse(feedDetailsModel.feeds[0].post.endDate))}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87),
                                            ),

                                            Text(
                                              '${DateFormat('dd-MM-yyyy').format(DateTime.parse(feedDetailsModel.feeds[0].post.startDate))}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[600]),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(top: 2.0),
                                            //   child: Text(
                                            //     "Thursday, June 4",
                                            //     style: TextStyle(color: Colors.grey[500]),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              feedDetailsModel.feeds[0].post.location,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800]),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(
                                                feedDetailsModel.feeds[0].post.audience,
                                                style: TextStyle(color: Colors.grey[500]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Open to the ",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[800]),
                                                ),
                                                Text(
                                                  "${feedDetailsModel.feeds[0].post.audience}",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[800]),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(
                                                "${typeList[ int.parse(feedDetailsModel.feeds[0].post.type)]} . ${classList[ int.parse(feedDetailsModel.feeds[0].post.type)]} . ${categoryList[ int.parse(feedDetailsModel.feeds[0].post.categoryId)]}",
                                                style: TextStyle(color: Colors.grey[500]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Divider(color: Colors.grey[400]),
                                    SizedBox(height: 15),
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
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    Constants.IMAGE_BASE_URL+ '${feedDetailsModel.feeds[0].profilePhoto}',

                                                    // 'https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Text(
                                                          '${feedDetailsModel.feeds[0].username}',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18)),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0),
                                                        child: Icon(
                                                          Icons.stars,
                                                          color: Colors.blue,
                                                          size: 17,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(
                                                        0.0, 4.5, 0.0, 0.0),
                                                    child: Text(
                                                      feedDetailsModel.feeds[0].description,
                                                      style: TextStyle(
                                                          fontSize: 16, color: Colors.grey),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${timeago.format(DateTime.parse(feedDetailsModel.feeds[0].post.creation))}",
                                                        style: TextStyle(color: Colors.grey),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(
                                                            10.0, 0.0, 0.0, 0.0),
                                                        child: Container(
                                                            height: 16,
                                                            width: 16,
                                                            child: Image.network(
                                                                "https://cdn3.iconfinder.com/data/icons/faticons/32/globe-01-512.png")),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
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
                                            SizedBox(width: 10),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ReadMoreText(
                                                    '${feedDetailsModel.feeds[0].post.description}',
                                                    trimLines: 3,
                                                    colorClickableText:
                                                    Colors.grey.withOpacity(0.9),
                                                    trimMode: TrimMode.Line,
                                                    trimCollapsedText: '...See More',
                                                    trimExpandedText: ' See Less',
                                                    style: TextStyle(
                                                        fontSize: 16, color: Colors.grey[700]),
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
                            //PEOPLE TAB
                            Scaffold(
                              body: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    //FOR GOING USERS
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Row(
                                                children: [
                                                 Divider(),
                                                  Text(
                                                    "Going (${feedDetailsModel.feeds[0].post.occupiedSeats})",
                                                    style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            ListView.separated(
                                              separatorBuilder: (ctx, interestedPos) {
                                                return Divider(indent: 15,);
                                              },
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: feedDetailsModel.feeds[0].post.goingUsers.length,
                                              itemBuilder: (ctx, goingPos) {
                                                return Container(
                                                  child: GestureDetector(
                                                    onTap: () => showDialog<String>(context: context,
                                                        builder: (BuildContext context) => BlocProvider<UserCommentBloc>(
                                                            create: (context) => UserCommentBloc(userCommentRepository: Repository()),
                                                            child: CommentersInfo()
                                                        ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 8.0),
                                                          child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15.0),
                                                              image: DecorationImage(
                                                                image: NetworkImage(
                                                                    Constants.IMAGE_BASE_URL+ feedDetailsModel.feeds[0].post.goingUsers[goingPos].profilePhoto),

                                                                // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          feedDetailsModel.feeds[0].post.goingUsers[goingPos].name,
                                                          style: TextStyle(
                                                              color: Colors.grey[800],
                                                              fontWeight: FontWeight.bold, fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),


                                    //FOR INTERESTED USERS
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Row(
                                                children: [

                                                  Text(
                                                    "Interested (${feedDetailsModel.feeds[0].post.interestedUsers.length})",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        letterSpacing: 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),

                                            ListView.separated(
                                            separatorBuilder: (ctx, interestedPos) {
                                            return Divider(indent: 15,);
                                            },
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                               itemCount: feedDetailsModel.feeds[0].post.interestedUsers.length,
                                              itemBuilder: (ctx, interestedPos) {
                                                return GestureDetector(
                                                  onTap: () => showDialog<String>(context: context,
                                                    builder: (BuildContext context) => BlocProvider<InterestedUserBloc>(
                                                        create: (context) => InterestedUserBloc(interestedUserRepository: Repository()),
                                                        child: InterestedUserScreen(userId: feedDetailsModel.feeds[0].post.interestedUsers[interestedPos].id,)
                                                    ),
                                                  ),
                                                  child: Row(

                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 8.0),
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(15.0),
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                   Constants.IMAGE_BASE_URL+'${feedDetailsModel.feeds[0].post.interestedUsers[interestedPos].profilePhoto}'
                                                             ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(top: 1.0),
                                                        child: Text(
                                                          '${feedDetailsModel.feeds[0].post.interestedUsers[interestedPos].name}',
                                                          style: TextStyle(
                                                              color: Colors.grey[800],
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 15),

                                  ],
                                ),
                              ),
                              floatingActionButton: FloatingActionButton(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.group_add,color:Colors.black87),
                                onPressed: (){
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                            return FractionallySizedBox(
                                                heightFactor: 0.80,
                                                child: BlocProvider<InviteUserBloc>(
                                                    create: (context) => InviteUserBloc(inviteUserRepository: Repository()),
                                                    child: InviteScreen()
                                                ),);
                                          });
                                    },
                                  );


                                },
                              ),
                            ),
                            //PUBLIC COMMENTS TAB
                            Scaffold(
                              body:ListView.builder(
                                itemCount:feedDetailsModel.feeds[0].post.commenters.length ,
                                  itemBuilder: (context,pos){
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage:NetworkImage(Constants.IMAGE_BASE_URL+feedDetailsModel.feeds[0].post.commenters[pos].profilePhoto) ,
                                          ),
                                          SizedBox(width:20),
                                          Expanded(
                                            flex: 8,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(feedDetailsModel.feeds[0].post.commenters[pos].name,style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text(feedDetailsModel.feeds[0].post.commenters[pos].content,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),),


                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(height:10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${timeago.format(DateTime.parse(feedDetailsModel.feeds[0].post.commenters[pos].creation))}",style: TextStyle(color: Colors.grey,fontSize: 13),),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                              floatingActionButton: FloatingActionButton(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.mode_comment_outlined,color:Colors.black87),
                                onPressed: (){
                                  showDialog<String>(context: context,
                                    builder: ( context) =>  BlocProvider<PostCommentBloc>(
                                        create: (context) =>
                                            PostCommentBloc(postCommentRepository: Repository()),
                                        child: PostCommentScreen(postId: feedDetailsModel.feeds[0].post.postId,)

                                    ),);
                                },
                              ),
                            ),
                            //PHOTOS TAB
                            Container(
                              child:BlocProvider<PostCommentBloc>(
                                  create: (context) =>
                                      PostCommentBloc(postCommentRepository: Repository()),
                                  child:   PhotosWidget(images:feedDetailsModel.feeds[0].post.images,postId:feedDetailsModel.feeds[0].post.postId),

                              ),)


                            //DETAILS TAB


                          ])),
                    )
                  ])
          ),

        ]),
      ),
    );
  }

  Widget buildLoading() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
