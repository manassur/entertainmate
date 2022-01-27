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
                Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        //FOR MODERATING USERS
                        widget.branch == 0
                            ? Container(
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
                                        "MODERATING (2)",
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
                                  // feedDetailsModel.feeds[0].post.moderatingUsers.length,
                                  itemBuilder:
                                      (ctx, interestedPos) {
                                    return ListTile(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .vertical(
                                                  top:
                                                  Radius.circular(25.0)),
                                            ),
                                            isScrollControlled:
                                            true,
                                            backgroundColor:
                                            Colors.white,
                                            builder:
                                                (context) {
                                              return FractionallySizedBox(
                                                heightFactor:
                                                0.5,
                                                child: BlocProvider<
                                                    InterestedUserBloc>(
                                                  create: (context) =>
                                                      InterestedUserBloc(
                                                          interestedUserRepository:
                                                          Repository()),
                                                  child: BlocProvider<
                                                      SaveInterestBloc>(
                                                      create: (context) => SaveInterestBloc(
                                                          saveInterestRepository:
                                                          Repository()),
                                                      child: InterestedUserScreen(
                                                          // postId: feedDetailsModel.feeds[0].post.postId,
                                                          // userId: feedDetailsModel.feeds[0].post.moderatingUsers[interestedPos].id,
                                                          // action: "moderating",
                                                          // actor: isAuthor ? 'author' : ''
                                                      )
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) {
                                            Map<String,
                                                dynamic>
                                            myData =
                                                value;
                                            resolvePostActions(
                                                myData[
                                                "action"],
                                                myData[
                                                "userId"]);
                                          });
                                        },
                                        leading: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 8.0),
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
                                              //       .IMAGE_BASE_URL + feedDetailsModel.feeds[0].post.moderatingUsers[interestedPos].profilePhoto),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                         "Somrthing here",
                                          // feedDetailsModel.feeds[0].post.moderatingUsers[interestedPos].name,
                                          style: TextStyle(
                                              color: Colors
                                                  .grey[800],
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              fontSize: 16),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                            : Container(),

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
                                Divider(),
                                ListView.separated(
                                  separatorBuilder:
                                      (ctx, interestedPos) {
                                    return Divider(
                                      indent: 15,
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  itemCount:
                                  3,
                                  // feedDetailsModel.feeds[0].post.goingUsers.length,
                                  itemBuilder: (ctx, goingPos) {
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
                                                  child:
                                                  BlocProvider<
                                                      SaveInterestBloc>(
                                                      create: (context) =>
                                                          SaveInterestBloc(
                                                              saveInterestRepository:
                                                              Repository()),
                                                      child:
                                                      InterestedUserScreen(
                                                        // postId:
                                                        // feedDetailsModel
                                                        //     .feeds[
                                                        // 0]
                                                        //     .post
                                                        //     .postId,
                                                        // userId: feedDetailsModel
                                                        //     .feeds[0]
                                                        //     .post
                                                        //     .goingUsers[
                                                        // goingPos]
                                                        //     .id,
                                                        // action:
                                                        // 'going',
                                                        // actor: isModerator
                                                        //     ? 'moderator'
                                                        //     : '',
                                                      )
                                                     ),),
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
                                              //           .goingUsers[
                                              //       goingPos]
                                              //           .profilePhoto),
                                              //
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "someth",
                                          // feedDetailsModel
                                          //     .feeds[0]
                                          //     .post
                                          //     .goingUsers[goingPos]
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
                                        "Going (2)",
                                        // widget.branch == 0
                                        //     ? "INTERESTED (${feedDetailsModel.feeds[0].post.interestedUsers.length})"
                                        //     : "LIKED (${feedDetailsModel.feeds[0].post.interestedUsers.length})",
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
                                  itemCount: 2,
                                  // feedDetailsModel
                                  //     .feeds[0]
                                  //     .post
                                  //     .interestedUsers
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
                                                  child:  BlocProvider<
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
                                                          //     .interestedUsers[
                                                          // interestedPos]
                                                          //     .id,
                                                          // action:
                                                          // "interested",
                                                          // actor: isModerator
                                                          //     ? "moderator"
                                                          //     : ''
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
                                              borderRadius: BorderRadius.circular(15.0),
                                              // image:
                                              // DecorationImage(
                                              //   image: NetworkImage(Constants
                                              //       .IMAGE_BASE_URL +
                                              //       feedDetailsModel
                                              //           .feeds[0]
                                              //           .post
                                              //           .interestedUsers[
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
//                                               .feeds[0]
//                                               .post
//                                               .interestedUsers[
//                                           interestedPos]
//                                               .name,
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
                        SizedBox(height: 15),
                        //FOR SAVED USERS
                        // Container(
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(
                        //         20.0, 20.0, 10.0, 0.0),
                        //     child: Column(
                        //       mainAxisAlignment:
                        //       MainAxisAlignment.start,
                        //       crossAxisAlignment:
                        //       CrossAxisAlignment.start,
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(
                        //               bottom: 8.0),
                        //           child: Row(
                        //             children: [
                        //               Divider(),
                        //               Text(
                        //                 "SAVED (${feedDetailsModel.feeds[0].post.savedUsers.length})",
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.grey,
                        //                     letterSpacing: 1),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Divider(),
                        //         ListView.separated(
                        //           separatorBuilder:
                        //               (ctx, interestedPos) {
                        //             return Divider(
                        //               indent: 15,
                        //             );
                        //           },
                        //           shrinkWrap: true,
                        //           physics:
                        //           NeverScrollableScrollPhysics(),
                        //           itemCount: feedDetailsModel
                        //               .feeds[0]
                        //               .post
                        //               .savedUsers
                        //               .length,
                        //           itemBuilder: (ctx, goingPos) {
                        //             return ListTile(
                        //                 onTap: () {
                        //                   showModalBottomSheet(
                        //                     context: context,
                        //                     shape:
                        //                     RoundedRectangleBorder(
                        //                       borderRadius:
                        //                       BorderRadius.vertical(
                        //                           top: Radius
                        //                               .circular(
                        //                               25.0)),
                        //                     ),
                        //                     isScrollControlled:
                        //                     true,
                        //                     backgroundColor:
                        //                     Colors.transparent,
                        //                     builder: (context) {
                        //                       return FractionallySizedBox(
                        //                         heightFactor: 0.5,
                        //                         child: BlocProvider<
                        //                             InterestedUserBloc>(
                        //                           create: (context) =>
                        //                               InterestedUserBloc(
                        //                                   interestedUserRepository:
                        //                                   Repository()),
                        //                           child: BlocProvider<
                        //                               SaveInterestBloc>(
                        //                               create: (context) =>
                        //                                   SaveInterestBloc(
                        //                                       saveInterestRepository:
                        //                                       Repository()),
                        //                               child: InterestedUserScreen(
                        //                                   postId: feedDetailsModel
                        //                                       .feeds[
                        //                                   0]
                        //                                       .post
                        //                                       .postId,
                        //                                   userId: feedDetailsModel
                        //                                       .feeds[
                        //                                   0]
                        //                                       .post
                        //                                       .savedUsers[
                        //                                   goingPos]
                        //                                       .id,
                        //                                   actor: '',
                        //                                   action:
                        //                                   '')),),
                        //                       );
                        //                     },
                        //                   ).then((value) {
                        //                     Map<String, dynamic>
                        //                     myData = value;
                        //                     resolvePostActions(
                        //                         myData["action"],
                        //                         myData["userId"]);
                        //                   });
                        //                 },
                        //                 leading: Padding(
                        //                   padding: const EdgeInsets
                        //                       .fromLTRB(
                        //                       0.0, 10.0, 10.0, 8.0),
                        //                   child: Container(
                        //                     height: 40,
                        //                     width: 40,
                        //                     decoration:
                        //                     BoxDecoration(
                        //                       borderRadius:
                        //                       BorderRadius
                        //                           .circular(
                        //                           15.0),
                        //                       image:
                        //                       DecorationImage(
                        //                         image: NetworkImage(Constants
                        //                             .IMAGE_BASE_URL +
                        //                             feedDetailsModel
                        //                                 .feeds[0]
                        //                                 .post
                        //                                 .savedUsers[
                        //                             goingPos]
                        //                                 .profilePhoto),
                        //
                        //                         // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                        //                         fit: BoxFit.cover,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 title: Text(
                        //                   feedDetailsModel
                        //                       .feeds[0]
                        //                       .post
                        //                       .savedUsers[goingPos]
                        //                       .name,
                        //                   style: TextStyle(
                        //                       color:
                        //                       Colors.grey[800],
                        //                       fontWeight:
                        //                       FontWeight.bold,
                        //                       fontSize: 16),
                        //                 ));
                        //           },
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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

