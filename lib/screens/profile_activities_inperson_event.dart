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
import 'happening_now.dart';
import 'invite_screen.dart';
import 'model/feed_details_model.dart';
import 'model/user.dart';
import 'private_room_screen.dart';
import 'utility/constants.dart' as Constants;
import 'package:timeago/timeago.dart' as timeago;


class ActivitiesInPersonEvent extends StatefulWidget {
  FeedDetailsModel feedDetailsModel;
  String postId;
  String action;
  String type;
  String name;
  int branch;
  PostCommentModel postCommentModel;

  ActivitiesInPersonEvent(
      {Key key,
        this.name,
        @required this.postCommentModel,
        this.feedDetailsModel,
        this.postId,
        this.action,
        this.type,
        this.branch});
  @override
  _ActivitiesInPersonEventState createState() => _ActivitiesInPersonEventState();
}

class _ActivitiesInPersonEventState extends State<ActivitiesInPersonEvent> {
  TextEditingController searchController = TextEditingController();

  FeedDetailsBloc feedDetailsBloc;
  SaveInterestBloc saveInterestBloc;
  FeedDetailsModel feedDetailsModel;
  Repository repository;
  bool isSaved = false,
      isInterested = false,
      isGoing = false,
      isModerator = false,
      isAuthor = false;
  PostCommentBloc postCommentBloc;
  User currentUser;
  TextEditingController commentController = TextEditingController();
  var audienceList = <String>[
    'Open to public',
    'Invited guests only',
  ];
  var classList = <String>[
    'Non - anonymous',
    'Anonymous',
  ];
  var typeList = <String>[
    'In-person',
    'Online',
  ];
  String dropdownValue = 'Category';
  var categoryList = <String>['Category', 'Social', 'Sports', 'Arts', 'Nature'];
  @override
  void initState() {
    super.initState();
    feedDetailsBloc = BlocProvider.of<FeedDetailsBloc>(context);

    saveInterestBloc = BlocProvider.of<SaveInterestBloc>(context);
    postCommentBloc = BlocProvider.of<PostCommentBloc>(context);
    repository = Repository();
    repository.getCurrentUser().then(
          (valuee) => {
        setState(() {
          currentUser = valuee;
        }),
      },
    );
  }

  void resolvePostActions(action, userId) {

    setState(() {
      if (action == "resign") {
        //add user to going
        feedDetailsModel.feeds[0].post.goingUsers.add(feedDetailsModel
            .feeds[0].post.moderatingUsers
            .firstWhere((element) => element.id == userId));
        // remove user from moderating
        feedDetailsModel.feeds[0].post.moderatingUsers
            .removeWhere((element) => element.id == userId);

      } else if (action == "interested") {
        //add user to interested
        feedDetailsModel.feeds[0].post.interestedUsers.add(feedDetailsModel
            .feeds[0].post.goingUsers
            .firstWhere((element) => element.id == userId));
        // remove user from going
        feedDetailsModel.feeds[0].post.goingUsers
            .removeWhere((element) => element.id == userId);

      } else if (action == "moderate") {
        //add user to goingfrom moderating
        feedDetailsModel.feeds[0].post.moderatingUsers.add(feedDetailsModel
            .feeds[0].post.goingUsers
            .firstWhere((element) => element.id == userId));
        // remove user from moderating
        feedDetailsModel.feeds[0].post.goingUsers
            .removeWhere((element) => element.id == userId);

      } else if (action == "going") {
        //add user from going to interested
        feedDetailsModel.feeds[0].post.goingUsers.add(feedDetailsModel
            .feeds[0].post.interestedUsers
            .firstWhere((element) => element.id == userId));
        // remove user from interested to going
        feedDetailsModel.feeds[0].post.interestedUsers
            .removeWhere((element) => element.id == userId);

      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("In-person Events",
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
              child: Icon(Icons.arrow_back_ios, color: Colors.black)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return FractionallySizedBox(
                      heightFactor: 0.80,
                      child:
                      AppBar(
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: Container(
                          margin: EdgeInsets.fromLTRB( 10.0, 20.0, 20.0, 15.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: searchController,
                            onChanged: (String txt) {},
                            style:  TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search here ',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                ),
                                prefixIcon: Icon(Icons.search, color: Colors.grey[400],),
                                suffixIcon: InkWell(
                                    onTap: (){
                                      searchController.clear();
                                    },
                                    child: Icon(Icons.cancel, size: 20, color: Colors.grey[400],))
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right:10.0),
                                child: Text(
                                  "Cancel", style: TextStyle(color: Colors.blue, fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  );
                },
              );
            },
          ),
        ],
      ),

      body: DefaultTabController(
        length: 4,
        child:  Scaffold(
          backgroundColor:Colors.grey[200],
          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child:  Container(
              margin: EdgeInsets.only(top: 1),
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration:BoxDecoration(
                        color:Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                      height: 40,
                      child: Center(
                        child: TabBar(
                            unselectedLabelColor: Colors.black87,
                            labelColor: Colors.black87,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.white]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tabs: [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Social"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Sports"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Arts"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Nature"),
                                ),
                              ),
                            ]),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          body:  TabBarView(
              children: <Widget>[
                //SOCIAL TAB
                BlocProvider<
                    FeedDetailsBloc>(
                    create: (context) =>
                        FeedDetailsBloc(
                            feedDetailsRepository:
                            Repository()),
                    child:
                    BuildEventList(type:'0',category:'1'),

                ),


                BlocProvider<
                    FeedDetailsBloc>(
                  create: (context) =>
                      FeedDetailsBloc(
                          feedDetailsRepository:
                          Repository()),
                  child:
                  BuildEventList(type:'0',category:'2'),

                ),
                BlocProvider<
                    FeedDetailsBloc>(
                  create: (context) =>
                      FeedDetailsBloc(
                          feedDetailsRepository:
                          Repository()),
                  child:
                  BuildEventList(type:'0',category:'3'),

                ),
                BlocProvider<
                    FeedDetailsBloc>(
                  create: (context) =>
                      FeedDetailsBloc(
                          feedDetailsRepository:
                          Repository()),
                  child:
                  BuildEventList(type:'0',category:'3'),

                ),
              ]

          ),
        ),
      ),

    );
  }

}

class BuildEventList extends StatefulWidget {
  String category,type;
   BuildEventList({Key key,this.category,this.type}) : super(key: key);

  @override
  _BuildEventListState createState() => _BuildEventListState();
}

class _BuildEventListState extends State<BuildEventList> {

  FeedDetailsBloc feedDetailsBloc;
  FeedDetailsModel feedDetailsModel;
  Repository repository;

  User currentUser;

  String dropdownValue = 'Category';
  var categoryList = <String>[ 'Social', 'Sports', 'Arts', 'Nature'];
  @override
  void initState() {
    super.initState();
    feedDetailsBloc = BlocProvider.of<FeedDetailsBloc>(context);
    feedDetailsBloc.add(
        FetchPostsByTypeAndCategoryEvent(type: widget.type, category: widget.category));

    repository = Repository();
    repository.getCurrentUser().then(
          (valuee) => {
        setState(() {
          currentUser = valuee;
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedDetailsBloc, FeedDetailsState>(
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
      child: Scaffold(
        body:  feedDetailsModel==null?Center(child: SizedBox(height:30,width:30,child: CircularProgressIndicator())):  SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              //FOR MODERATING USERS
                Container(
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(
                      20.0, 20.0, 10.0, 0.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(
                            bottom: 8.0),
                        child: Row(
                          children: [
                            Text(
                              // "MODERATING (${feedDetailsModel.feeds[0].post.moderatingUsers.length})",
                              feedDetailsModel==null?"MODERATING (0)":"MODERATING (${feedDetailsModel.feeds.where((element) => element.post.status=="4").toList().length})",
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                  Colors.grey,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                     feedDetailsModel==null? Container():
               buildEventItem(feedDetailsModel.feeds.where((element) => element.post.status=="4").toList())

      ],
                  ),
                ),
              ),


              SizedBox(height: 15),
              //FOR GOING/CONFIRMED USERS
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20.0, 20.0, 10.0, 0.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0),
                        child: Row(
                          children: [
                            Divider(),
                            Text(
                              feedDetailsModel==null?"GOING (0)":"GOING (${feedDetailsModel.feeds.where((element) => element.post.status=="3").toList().length})",
                              // widget.branch == 0
                              //     ? "GOING (${feedDetailsModel.feeds[0].post.goingUsers.length})"
                              //     : "CONFIRMED (${feedDetailsModel.feeds[0].post.goingUsers.length})",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      feedDetailsModel==null? Container():
                      buildEventItem(feedDetailsModel.feeds.where((element) => element.post.status=="3").toList())

                    ],
                  ),
                ),
              ),

              //FOR INTERESTED USERS
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20.0, 20.0, 10.0, 0.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0),
                        child: Row(
                          children: [
                            Text(
                              feedDetailsModel==null?"INTERESTED (0)":"INTERESTED (${feedDetailsModel.feeds.where((element) => element.post.status=="2").toList().length})",
                              // widget.branch == 0
                              //     ? "GOING (${feedDetailsModel.feeds[0].post.goingUsers.length})"
                              //     : "CONFIRMED (${feedDetailsModel.feeds[0].post.goingUsers.length})",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      feedDetailsModel==null? Container():
                      buildEventItem(feedDetailsModel.feeds.where((element) => element.post.status=="2").toList())
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),
              //FOR INVITED USERS
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20.0, 20.0, 10.0, 0.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0),
                        child: Row(
                          children: [
                            Divider(),
                            Text(
                              feedDetailsModel==null?"INVITED (0)":"INVITED (${feedDetailsModel.feeds.where((element) => element.post.status=="1").toList().length})",
                              // widget.branch == 0
                              //     ? "GOING (${feedDetailsModel.feeds[0].post.goingUsers.length})"
                              //     : "CONFIRMED (${feedDetailsModel.feeds[0].post.goingUsers.length})",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      feedDetailsModel==null? Container():
                      buildEventItem(feedDetailsModel.feeds.where((element) => element.post.status=="1").toList())
                      ,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildEventItem(List<Feeds> oldEventModel){
    return  ListView.builder(
        itemCount: oldEventModel.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,pos){
          return  Stack(
            children: [
              InkWell(
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
                          child: HappeningNowScreen(postId: oldEventModel[pos].post.postId,name:oldEventModel[pos].name,branch:0)
                      ),
                  )
                  );
                },

                child: Container(
                  margin: EdgeInsets.fromLTRB( 20.0, 15.0, 20.0, 0.0),
                  padding: EdgeInsets.fromLTRB( 20.0, 10.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade600, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              '${oldEventModel[pos].username}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),

                      SizedBox(height: 5),

                      Text(
                        "${oldEventModel[pos].post.content}",
                        style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),),

                      SizedBox(height: 5),

                      // Text("June 4 2021 ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                      Text("${DateFormat('dd-MM-yyyy').format(DateTime.parse(oldEventModel[0].post.startDate))} ${DateFormat('HH:mma').format(DateTime.parse(oldEventModel[0].post.startDate))} - ${DateFormat('HH:mma').format(DateTime.parse(oldEventModel[0].post.endDate))}", style: TextStyle(fontSize: 13, color: Colors.deepOrange.withOpacity(0.5)),),
                      // Text(
                      //     "2 Andover Rd, Athens, OH 45701",
                      //     style: TextStyle( fontSize: 13,  decoration: TextDecoration.underline,
                      //     )),

                      SizedBox(height: 15),

                      Container(
                        padding: EdgeInsets.fromLTRB(5.0, 3.0, 15.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(13.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 13.0,
                              backgroundImage: NetworkImage("${Constants.IMAGE_BASE_URL}${oldEventModel[pos].profilePhoto}",),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${oldEventModel[pos].name}",  style: TextStyle( fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
                                Text("${timeago.format(DateTime.parse(oldEventModel[pos].post.creation))}",  style: TextStyle( fontSize: 10, color: Colors.grey.shade500)),

                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                        child: Divider(color: Colors.grey),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Reactions ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                              Text("${oldEventModel[pos].post.saves}",
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                            ],
                          ),
                          Spacer(),

                          Row(
                            children: [
                              Text(
                                  "${oldEventModel[pos].post.comments}",
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                              Text(" Comments", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                            ],
                          ),

                          SizedBox(width: 12.0,),

                          Row(
                            children: [
                              Text(
                                  "${oldEventModel[pos].post.interests}",
                                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                              Text(" Shares", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Positioned(
              //   right: 17.0,
              //   top: 28.0,
              //   child: RotationTransition(
              //     turns:  AlwaysStoppedAnimation(20 / 200),
              //     child:  Container(
              //         padding: EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
              //         decoration: BoxDecoration(
              //             color: Colors.grey,
              //             borderRadius: BorderRadius.circular(20.0)
              //         ),
              //         child: Text("Passed", style: TextStyle(color: Colors.white, fontSize: 12),)),
              //   ),
              // )
            ],
          );
        },
      )
    ;
  }

}


