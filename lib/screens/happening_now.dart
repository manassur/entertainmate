import 'package:entertainmate/bloc/feed_details/feed_details_bloc.dart';
import 'package:entertainmate/bloc/feed_details/feed_details_event.dart';
import 'package:entertainmate/bloc/feed_details/feed_details_state.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_event.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_event.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_state.dart';
import 'package:entertainmate/bloc/user_comment/user_comment_bloc.dart';
import 'package:entertainmate/screens/model/post_comment_model.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/utility/read_more.dart';
import 'package:entertainmate/widgets/people_dialog_info.dart';
import 'package:entertainmate/widgets/photos_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'model/feed_details_model.dart';

class HappeningNowScreen extends StatefulWidget {
  FeedDetailsModel feedDetailsModel;
  String postId;
  String action;
  String type;
  PostCommentModel postCommentModel;

  HappeningNowScreen({Key key, @required this.postCommentModel, this.feedDetailsModel, this.postId, this.action, this.type});

  @override
  _HappeningNowScreenState createState() => _HappeningNowScreenState();
}

class _HappeningNowScreenState extends State<HappeningNowScreen> {
  FeedDetailsBloc feedDetailsBloc;
  SaveInterestBloc saveInterestBloc;
  Repository repository;
  FeedDetailsModel feedDetailsModel = FeedDetailsModel();
  bool isSaved=false;
  PostCommentBloc postCommentBloc;
  TextEditingController commentController = TextEditingController();

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Happening Now",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Back",
              style: TextStyle(color: Colors.grey[900]),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            onPressed: () {},
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
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      SizedBox(height: 5),
                      Text("Save")
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.grey[300],
                        ),
                        child: Icon(Icons.add_outlined),
                      ),
                      SizedBox(height: 5),
                      Text("Invite")
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: Container(
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height:45,
                                          child: Center(
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              decoration:InputDecoration(
                                                  counterText: "",
                                                  // border:InputBorder.none,
                                               border: OutlineInputBorder(
                                                   borderSide: BorderSide(color: Colors.grey[300]),
                                                   borderRadius: BorderRadius.circular(15.0)
                                               ),
                                                  hintText: 'Write your comment...'
                                              ),
                                              onChanged:(value) {
                                                setState(() { });
                                              },
                                              controller: commentController,

                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Padding(padding: const EdgeInsets.all(10.0),
                                        child: InkWell(
                                          onTap: (){
                                            postCommentBloc.add(PostingCommentEvent(postId: "1", comment: commentController.text));
                                            print( "checking posting comment status status");

                                          },
                                          child: Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(child: Text("Post Comment",
                                              style: TextStyle(color: Colors.white,),)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[300],
                            ),
                            child:Icon(Icons.mode_comment_outlined),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("Comment")
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          saveInterestBloc.add(FetchInterestEvent(postId: "1", type: "1", action: "1"));
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[300],
                            ),
                            child:Icon(Icons.thumb_up_alt_outlined),),
                      ),
                      SizedBox(height: 5),
                      Text("Interested")
                    ],
                  ),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0.3),
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
                          Row(
                            children: [
                              Text(
                                "Today ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                              Text(
                                "7.00 ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                              Text(
                                "pm ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                              Text(
                                "until ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                              Text(
                                "9.00 ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                              Text(
                                "pm",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "Thursday, June 4",
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
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ping Rec Center ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "82 S Green Dr. Athens.OH",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "In-person event",
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
                              "Looking for 4 people",
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
                                    'https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
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
                                    "Physical education, M.Sc",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "5hr ",
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
                          bottom: TabBar(
                            unselectedLabelColor: Colors.grey[700],
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Colors.blue,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              // Creates border
                              color: Colors.lightBlueAccent.shade100
                                  .withOpacity(0.2),
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
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Divider(color: Colors.grey[400]),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      child: Container(
                          height: 1000, //height of TabBarView SOEMTHING HAS TO BE DONE
                          //ABOUT THIS STATIC HEIGHT FOR THE TABBAR

                          child: TabBarView(children: <Widget>[
                            //PEOPLE TAB
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  //FOR GOING USERS
                                  Container(
                                    child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.keyboard_arrow_down_outlined,
                                                      size: 25, color: Colors.grey,
                                                    ),
                                                    Text(
                                                      "Going (2 out of 4)",
                                                      style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          crossAxisSpacing: 10.0,
                                                          mainAxisSpacing: 10.0),
                                                  shrinkWrap: true,
                                                  // itemCount: feedDetailsModel.feeds[0].post.goingUsers.length,
                                                  itemCount: 7,
                                                  itemBuilder: (ctx, pos) {
                                                    return Expanded(
                                                      child: Container(
                                                        child: GestureDetector(
                                                          onTap: () => showDialog<String>(context: context,
                                                              builder: (BuildContext context) => BlocProvider<UserCommentBloc>(
                                                                  create: (context) => UserCommentBloc(userCommentRepository: Repository()),
                                                                  child: CustomDialogBox()
                                                              ),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                                                                child: Container(
                                                                  height: 90,
                                                                  width: 90,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(35.0),
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUmNfQXFzD5vLQlTtEkXH8hMKw2OzKjAkEog&usqp=CAU'),

                                                                      // '${feedDetailsModel.feeds[0].post.goingUsers[0].profilePhoto}'),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "Adri",
                                                                style: TextStyle(
                                                                    color: Colors.grey[800],
                                                                    fontWeight: FontWeight.bold, fontSize: 16),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),

                                  SizedBox(height: 15),

                                  //FOR INTERESTED USERS
                                  Container(
                                    child: Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.keyboard_arrow_down_outlined,
                                                    size: 25,
                                                    color: Colors.grey,
                                                  ),
                                                  Text(
                                                    "Interested (5)",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        letterSpacing: 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        crossAxisSpacing: 10.0,
                                                        mainAxisSpacing: 10.0),
                                                shrinkWrap: true,
                                                // itemCount: feedDetailsModel.feeds[0].post.interestedUsers.length,
                                                itemCount: 14,
                                                itemBuilder: (ctx, pos) {
                                                  return Expanded(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 65,
                                                          width: 65,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(25.0),
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                  // '${feedDetailsModel.feeds[0].post.interestedUsers[0].profilePhoto}'
                                                                  'https://miro.medium.com/max/1500/1*obNLhNFoyq7hncg1c6HZTg.jpeg'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 1.0),
                                                          child: Text(
                                                            "Micheal",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[800],
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 16),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 15),

                                  //COMMENTS BY USERS
                                  Container(
                                    child: Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.keyboard_arrow_down_outlined,
                                                    size: 25,
                                                    color: Colors.grey,
                                                  ),
                                                  Text(
                                                    "Comments (10)",
                                                    style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: GridView.builder(
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        crossAxisSpacing: 10.0,
                                                        mainAxisSpacing: 10.0),
                                                shrinkWrap: true,
                                                itemCount: 13,
                                                itemBuilder: (ctx, pos) {
                                                  return Expanded(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 65,
                                                          width: 65,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(25.0),
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                  // '${feedDetailsModel.feeds[0].post.commenters[0].profilePhoto}'
                                                                  'https://dynaimage.cdn.cnn.com/cnn/c_fill,g_auto,w_1200,h_675,ar_16:9/https%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F210526195007-john-benjamin-thornton.jpg'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 5.0),
                                                              child: Icon(
                                                                Icons.stars,
                                                                color: Colors.blue,
                                                                size: 17,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Shamim",
                                                              style: TextStyle(
                                                                  color: Colors.grey[800],
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //PHOTOS TAB
                            Container(
                              child: PhotosWidget(),
                            ),

                            //DETAILS TAB
                            Container(
                              child: SingleChildScrollView(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 0.0, 10.0, 0.0),
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
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                "More details about this event",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                    letterSpacing: 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '${feedDetailsModel.feeds[0].post.description}',
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

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
