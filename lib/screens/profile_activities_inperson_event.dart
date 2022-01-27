import 'package:entertainmate/bloc/feed_details/feed_details_bloc.dart';
import 'package:entertainmate/bloc/feed_details/feed_details_event.dart';
import 'package:entertainmate/bloc/interested_user/interested_user_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_bloc.dart';
import 'package:entertainmate/screens/interested_user_screen.dart';
import 'package:entertainmate/screens/model/post_comment_model.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/widgets/profile_activities_inperson_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/feed_details_model.dart';
import 'model/user.dart';


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
    feedDetailsBloc.add(
        FetchFeedDetailsEvent(postId: widget.postId, branch: widget.branch));

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
                    child: ProfileActivitiesInPersonSearch()
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
                Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [

                        //MODERATING
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
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
                                         "Moderating (2)",
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder: (ctx, goingPos) {
                                    return Container(
                                      margin:EdgeInsets.only(bottom: 10.0),
                                      padding: EdgeInsets.fromLTRB( 20.0, 10.0, 20.0, 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(1.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                            spreadRadius: 1.0
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Mafia (Warewolf)',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                                  SizedBox(height: 5),

                                                  Text(
                                                    "somthing",
                                                    style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),),

                                                  SizedBox(height: 5),

                                                  Text("June 4 2021 ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                  Text("9:00 PM - 12:00 AM", style: TextStyle(fontSize: 13, color: Colors.deepOrange.withOpacity(0.5)),),
                                                  Text(
                                                      "2 Andover Rd, Athens, OH 45701",
                                                      style: TextStyle( fontSize: 13,  decoration: TextDecoration.underline,
                                                      )),

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
                                                          backgroundImage: AssetImage("images/entertainmate_pic.jpeg",),
                                                          backgroundColor: Colors.transparent,
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Name name name",  style: TextStyle( fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
                                                            Text("June 1, 2021",  style: TextStyle( fontSize: 10, color: Colors.grey.shade500)),

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,)
                                            ],
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
                                                  Text("250",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),
                                              Spacer(),

                                              Row(
                                                children: [
                                                  Text(
                                                      "1K",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                  Text(" Comments", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),

                                              SizedBox(width: 12.0,),

                                              Row(
                                                children: [
                                                  Text(
                                                      "500",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                  Text(" Shares", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        //FOR GOING USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
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
                                        "Going (3)",
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder: (ctx, goingPos) {
                                    return Container(
                                      margin:EdgeInsets.only(bottom: 10.0),
                                      padding: EdgeInsets.fromLTRB( 20.0, 10.0, 20.0, 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1.0, 1.0), //(x,y)
                                              blurRadius: 6.0,
                                              spreadRadius: 1.0
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'PickleBall',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                                  SizedBox(height: 5),

                                                  Text(
                                                    "In-person ",
                                                    style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),),

                                                  SizedBox(height: 5),

                                                  Text("June 4 2021 ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                  Text("9:00 PM - 12:00 AM", style: TextStyle(fontSize: 13, color: Colors.deepOrange.withOpacity(0.5)),),
                                                  Text(
                                                      "2 Andover Rd, Athens, OH 45701",
                                                      style: TextStyle( fontSize: 13,  decoration: TextDecoration.underline,
                                                      )),

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
                                                          backgroundImage: AssetImage("images/entertainmate_pic.jpeg",),
                                                          backgroundColor: Colors.transparent,
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Name name name",  style: TextStyle( fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
                                                            Text("June 1, 2021",  style: TextStyle( fontSize: 10, color: Colors.grey.shade500)),

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,)
                                            ],
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
                                                  Text("250",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),
                                              Spacer(),

                                              Row(
                                                children: [
                                                  Text(
                                                      "1K",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                  Text(" Comments", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),

                                              SizedBox(width: 12.0,),

                                              Row(
                                                children: [
                                                  Text(
                                                      "500",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                  Text(" Shares", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        //FOR INVITED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),

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
                                        "INVITED (4)",
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
                                  separatorBuilder:
                                      (ctx, interestedPos) {
                                    return Divider(
                                      indent: 15,
                                    );
                                  },
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  // feedDetailsModel
                                  //     .feeds[0]
                                  //     .post
                                  //     .invitedUsers
                                  //     .length,
                                  itemBuilder:
                                      (ctx, interestedPos) {
                                    return ListTile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius
                                                      .circular(
                                                      25.0)),
                                            ),
                                            isScrollControlled:
                                            true,
                                            backgroundColor:
                                            Colors.white,
                                            builder: (context) {
                                              return FractionallySizedBox(
                                                heightFactor: 0.5,
                                                child: BlocProvider<
                                                    InterestedUserBloc>(
                                                  create: (context) =>
                                                      InterestedUserBloc(
                                                          interestedUserRepository:
                                                          Repository()),
                                                  child: BlocProvider<
                                                      SaveInterestBloc>(
                                                      create: (context) =>
                                                          SaveInterestBloc(
                                                              saveInterestRepository:
                                                              Repository()),
                                                      child: InterestedUserScreen(
                                                          // postId: feedDetailsModel
                                                          //     .feeds[
                                                          // 0]
                                                          //     .post
                                                          //     .postId,
                                                          // userId: feedDetailsModel
                                                          //     .feeds[
                                                          // 0]
                                                          //     .post
                                                          //     .invitedUsers[
                                                          // interestedPos]
                                                          //     .id,
                                                          // actor: '',
                                                          // action:
                                                          // ''
                                                      )),),
                                              );
                                            },
                                          ).then((value) {
                                            Map<String, dynamic>
                                            myData = value;
                                            resolvePostActions(
                                                myData["action"],
                                                myData["userId"]);
                                          });
                                        },
                                        leading: Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(
                                              0.0, 10.0, 10.0, 8.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration:
                                            BoxDecoration(
                                              color: Colors.grey[500],
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15.0),
                                              // image:
                                              // DecorationImage(
                                              //   image: NetworkImage(Constants
                                              //       .IMAGE_BASE_URL +
                                              //       feedDetailsModel
                                              //           .feeds[0]
                                              //           .post
                                              //           .invitedUsers[
                                              //       interestedPos]
                                              //           .profilePhoto),
                                              //
                                              //   // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "feedDetailsModel",
                                          // feedDetailsModel
                                          //     .feeds[0]
                                          //     .post
                                          //     .invitedUsers[
                                          // interestedPos]
                                          //     .name,
                                          style: TextStyle(
                                              color:
                                              Colors.grey[800],
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 16),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        //FOR INTERESTED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
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
                                        "Interested (4)",
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
                                  separatorBuilder:
                                      (ctx, interestedPos) {
                                    return Divider(
                                      indent: 15,
                                    );
                                  },
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  // feedDetailsModel
                                  //     .feeds[0]
                                  //     .post
                                  //     .invitedUsers
                                  //     .length,
                                  itemBuilder:
                                      (ctx, interestedPos) {
                                    return ListTile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius
                                                      .circular(
                                                      25.0)),
                                            ),
                                            isScrollControlled:
                                            true,
                                            backgroundColor:
                                            Colors.white,
                                            builder: (context) {
                                              return FractionallySizedBox(
                                                heightFactor: 0.5,
                                                child: BlocProvider<
                                                    InterestedUserBloc>(
                                                  create: (context) =>
                                                      InterestedUserBloc(
                                                          interestedUserRepository:
                                                          Repository()),
                                                  child: BlocProvider<
                                                      SaveInterestBloc>(
                                                      create: (context) =>
                                                          SaveInterestBloc(
                                                              saveInterestRepository:
                                                              Repository()),
                                                      child: InterestedUserScreen(
                                                        // postId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .postId,
                                                        // userId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .invitedUsers[
                                                        // interestedPos]
                                                        //     .id,
                                                        // actor: '',
                                                        // action:
                                                        // ''
                                                      )),),
                                              );
                                            },
                                          ).then((value) {
                                            Map<String, dynamic>
                                            myData = value;
                                            resolvePostActions(
                                                myData["action"],
                                                myData["userId"]);
                                          });
                                        },
                                        leading: Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(
                                              0.0, 10.0, 10.0, 8.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration:
                                            BoxDecoration(
                                              color: Colors.grey[500],
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15.0),
                                              // image:
                                              // DecorationImage(
                                              //   image: NetworkImage(Constants
                                              //       .IMAGE_BASE_URL +
                                              //       feedDetailsModel
                                              //           .feeds[0]
                                              //           .post
                                              //           .invitedUsers[
                                              //       interestedPos]
                                              //           .profilePhoto),
                                              //
                                              //   // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "feedDetailsModel",
                                          // feedDetailsModel
                                          //     .feeds[0]
                                          //     .post
                                          //     .invitedUsers[
                                          // interestedPos]
                                          //     .name,
                                          style: TextStyle(
                                              color:
                                              Colors.grey[800],
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 16),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),


                        //FOR SAVED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
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
                                        "Saved (0)",
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
                                  separatorBuilder:
                                      (ctx, interestedPos) {
                                    return Divider(
                                      indent: 15,
                                    );
                                  },
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 0,
                                  // feedDetailsModel
                                  //     .feeds[0]
                                  //     .post
                                  //     .invitedUsers
                                  //     .length,
                                  itemBuilder:
                                      (ctx, interestedPos) {
                                    return ListTile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius
                                                      .circular(
                                                      25.0)),
                                            ),
                                            isScrollControlled:
                                            true,
                                            backgroundColor:
                                            Colors.white,
                                            builder: (context) {
                                              return FractionallySizedBox(
                                                heightFactor: 0.5,
                                                child: BlocProvider<
                                                    InterestedUserBloc>(
                                                  create: (context) =>
                                                      InterestedUserBloc(
                                                          interestedUserRepository:
                                                          Repository()),
                                                  child: BlocProvider<
                                                      SaveInterestBloc>(
                                                      create: (context) =>
                                                          SaveInterestBloc(
                                                              saveInterestRepository:
                                                              Repository()),
                                                      child: InterestedUserScreen(
                                                        // postId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .postId,
                                                        // userId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .invitedUsers[
                                                        // interestedPos]
                                                        //     .id,
                                                        // actor: '',
                                                        // action:
                                                        // ''
                                                      )),),
                                              );
                                            },
                                          ).then((value) {
                                            Map<String, dynamic>
                                            myData = value;
                                            resolvePostActions(
                                                myData["action"],
                                                myData["userId"]);
                                          });
                                        },
                                        leading: Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(
                                              0.0, 10.0, 10.0, 8.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration:
                                            BoxDecoration(
                                              color: Colors.grey[500],
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15.0),
                                              // image:
                                              // DecorationImage(
                                              //   image: NetworkImage(Constants
                                              //       .IMAGE_BASE_URL +
                                              //       feedDetailsModel
                                              //           .feeds[0]
                                              //           .post
                                              //           .invitedUsers[
                                              //       interestedPos]
                                              //           .profilePhoto),
                                              //
                                              //   // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "feedDetailsModel",
                                          // feedDetailsModel
                                          //     .feeds[0]
                                          //     .post
                                          //     .invitedUsers[
                                          // interestedPos]
                                          //     .name,
                                          style: TextStyle(
                                              color:
                                              Colors.grey[800],
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 16),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),


                        //FOR INVITED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                        "Invited (1)",
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
                                  separatorBuilder:
                                      (ctx, interestedPos) {
                                    return Divider(
                                      indent: 15,
                                    );
                                  },
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  // feedDetailsModel
                                  //     .feeds[0]
                                  //     .post
                                  //     .invitedUsers
                                  //     .length,
                                  itemBuilder:
                                      (ctx, interestedPos) {
                                    return ListTile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius
                                                      .circular(
                                                      25.0)),
                                            ),
                                            isScrollControlled:
                                            true,
                                            backgroundColor:
                                            Colors.white,
                                            builder: (context) {
                                              return FractionallySizedBox(
                                                heightFactor: 0.5,
                                                child: BlocProvider<
                                                    InterestedUserBloc>(
                                                  create: (context) =>
                                                      InterestedUserBloc(
                                                          interestedUserRepository:
                                                          Repository()),
                                                  child: BlocProvider<
                                                      SaveInterestBloc>(
                                                      create: (context) =>
                                                          SaveInterestBloc(
                                                              saveInterestRepository:
                                                              Repository()),
                                                      child: InterestedUserScreen(
                                                        // postId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .postId,
                                                        // userId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .invitedUsers[
                                                        // interestedPos]
                                                        //     .id,
                                                        // actor: '',
                                                        // action:
                                                        // ''
                                                      )),),
                                              );
                                            },
                                          ).then((value) {
                                            Map<String, dynamic>
                                            myData = value;
                                            resolvePostActions(
                                                myData["action"],
                                                myData["userId"]);
                                          });
                                        },
                                        leading: Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(
                                              0.0, 10.0, 10.0, 8.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration:
                                            BoxDecoration(
                                              color: Colors.grey[500],
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15.0),
                                              // image:
                                              // DecorationImage(
                                              //   image: NetworkImage(Constants
                                              //       .IMAGE_BASE_URL +
                                              //       feedDetailsModel
                                              //           .feeds[0]
                                              //           .post
                                              //           .invitedUsers[
                                              //       interestedPos]
                                              //           .profilePhoto),
                                              //
                                              //   // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "feedDetailsModel",
                                          // feedDetailsModel
                                          //     .feeds[0]
                                          //     .post
                                          //     .invitedUsers[
                                          // interestedPos]
                                          //     .name,
                                          style: TextStyle(
                                              color:
                                              Colors.grey[800],
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 16),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        //FOR COMMENTED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
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
                                        "Commented (1)",
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
                                  separatorBuilder:
                                      (ctx, interestedPos) {
                                    return Divider(
                                      indent: 15,
                                    );
                                  },
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  // feedDetailsModel
                                  //     .feeds[0]
                                  //     .post
                                  //     .invitedUsers
                                  //     .length,
                                  itemBuilder:
                                      (ctx, interestedPos) {
                                    return ListTile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius
                                                      .circular(
                                                      25.0)),
                                            ),
                                            isScrollControlled:
                                            true,
                                            backgroundColor:
                                            Colors.white,
                                            builder: (context) {
                                              return FractionallySizedBox(
                                                heightFactor: 0.5,
                                                child: BlocProvider<
                                                    InterestedUserBloc>(
                                                  create: (context) =>
                                                      InterestedUserBloc(
                                                          interestedUserRepository:
                                                          Repository()),
                                                  child: BlocProvider<
                                                      SaveInterestBloc>(
                                                      create: (context) =>
                                                          SaveInterestBloc(
                                                              saveInterestRepository:
                                                              Repository()),
                                                      child: InterestedUserScreen(
                                                        // postId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .postId,
                                                        // userId: feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .invitedUsers[
                                                        // interestedPos]
                                                        //     .id,
                                                        // actor: '',
                                                        // action:
                                                        // ''
                                                      )),),
                                              );
                                            },
                                          ).then((value) {
                                            Map<String, dynamic>
                                            myData = value;
                                            resolvePostActions(
                                                myData["action"],
                                                myData["userId"]);
                                          });
                                        },
                                        leading: Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(
                                              0.0, 10.0, 10.0, 8.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration:
                                            BoxDecoration(
                                              color: Colors.grey[500],
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15.0),
                                              // image:
                                              // DecorationImage(
                                              //   image: NetworkImage(Constants
                                              //       .IMAGE_BASE_URL +
                                              //       feedDetailsModel
                                              //           .feeds[0]
                                              //           .post
                                              //           .invitedUsers[
                                              //       interestedPos]
                                              //           .profilePhoto),
                                              //
                                              //   // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "feedDetailsModel",
                                          // feedDetailsModel
                                          //     .feeds[0]
                                          //     .post
                                          //     .invitedUsers[
                                          // interestedPos]
                                          //     .name,
                                          style: TextStyle(
                                              color:
                                              Colors.grey[800],
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 16),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                      ],
                    ),
                  ),
                ),

                Container(color: Colors.red,),
                Container(color: Colors.blueAccent,),
                Container(color: Colors.deepOrange,),
              ]

          ),
        ),
      ),

    );
  }
}

