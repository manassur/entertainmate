import 'package:entertainmate/bloc/feed_details/feed_details_bloc.dart';
import 'package:entertainmate/bloc/invite_user/inviter_user_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_bloc.dart';
import 'package:entertainmate/screens/happening_now.dart';
import 'package:entertainmate/screens/personal_profile_followers.dart';
import 'package:entertainmate/screens/personal_profile_following.dart';
import 'package:entertainmate/screens/profile_activities_inperson_event.dart';
import 'package:entertainmate/screens/profile_activities_interest.dart';
import 'package:entertainmate/screens/profile_activities_online_event.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../invite.dart';
import 'utility/complete_profile_provider.dart';
import 'utility/constants.dart' as Constants;

class PersonalProfileScreen extends StatefulWidget {

  @override
  _PersonalProfileScreenState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,

            body: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Column(
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
                              labelPadding: EdgeInsets.all(0),
                              tabs: [
                                Tab(
                                  text: "Biography",
                                ),
                                Tab(
                                  text: "Activities",
                                ),
                                Tab(
                                  text: "Messages",
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                          height: 650,
                          child: TabBarView(children: <Widget>[
                            //BIOGRAPHY TAB
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                color: Colors.grey[100],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                Constants.IMAGE_BASE_URL+ data.user.profilePhoto),
                                            )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(data.user.firstname,
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0,
                                        ),),
                                    ),
                                    Text(data.user.headline,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),),
                                    Text("@" + data.user.username,
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.0,
                                      )),

                                    SizedBox(height: 30),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonalProfileFollowers()));
                                          },
                                          child: Column(
                                            children: [
                                              Text("1", style: TextStyle(
                                                  fontWeight: FontWeight.w600),),
                                              Text('Followers',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonalProfileFollowing()));

                                          },
                                          child: Column(
                                            children: [
                                              Text('1', style: TextStyle(
                                                  fontWeight: FontWeight.w600),),
                                              Text('Following',
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .w600),),
                                            ],
                                          ),
                                        ),
                                        MaterialButton(
                                          elevation: 0,
                                          onPressed: () {
                                            if (data.user.invites < 5) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Invite()));
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'You have used up your invites',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                            }
                                          },
                                          color: data.user.invites < 5
                                              ? Colors.lightBlueAccent.withOpacity(0.1)
                                              : Colors.blue,
                                          disabledColor: Colors.grey[400],
                                          child: Text(
                                            '    Invite Friends    ',
                                            style: TextStyle(
                                                color: Colors.grey[800]),),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Divider(color: Colors.black87,),
                                    Container(
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 30.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                  'images/005-instagram.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user
                                                      .instagram
                                                      .isNotEmpty ? Colors
                                                      .black87 : Colors
                                                      .grey,),
                                                SvgPicture.asset(
                                                  'images/004-twitter.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user.twitter
                                                      .isNotEmpty ? Colors
                                                      .black87 : Colors
                                                      .grey,),
                                                SvgPicture.asset(
                                                  'images/003-facebook.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user
                                                      .facebook.isNotEmpty
                                                      ? Colors.black87
                                                      : Colors.grey,),
                                                SvgPicture.asset(
                                                  'images/002-linkedin-logo.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user
                                                      .linkedin.isNotEmpty
                                                      ? Colors.black87
                                                      : Colors.grey,),
                                                SvgPicture.asset(
                                                  'images/001-email.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user.email
                                                      .isNotEmpty ? Colors
                                                      .black87 : Colors
                                                      .grey,),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 40),

                                          Center(
                                              child: Text("MORE ABOUT ME", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)),

                                          SizedBox(height: 15),

                                          Container(
                                            padding: EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10.0)
                                            ),
                                            child: Text(data.user.headline,
                                              // child: Text(data.user.bio,

                                                style: TextStyle(fontWeight: FontWeight.w500, height: 1.5, wordSpacing: 1),),)
                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                              ),
                            ),


                            //ACTIVITIES TAB
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                                height: MediaQuery.of(context).size.height,
                                color: Colors.grey[200],
                                child:
                                  GridView.extent(
                                    primary: false,
                                    padding: const EdgeInsets.all(16),
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 30,
                                    maxCrossAxisExtent: 200.0,
                                      children: <Widget>[
                                        //IN-PERSON EVENTS
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
                                                    child: ActivitiesInPersonEvent(
                                                      type: "0", // inperson events
                                                    )
                                                ),
                                            )
                                            );
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0.7, 0.7), // changes position of shadow
                                                  ),
                                                ],),
                                              child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                      height: 42,
                                                      padding: EdgeInsets.only(left: 5.0),
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey[400],
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:  Radius.circular(12.0),
                                                            bottomRight:  Radius.circular(12.0),
                                                          ),
                                                      ),
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text("In-person Events",
                                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                        ),
                                                      )
                                                  )
                                              )
                                          ),
                                        ),

                                        //ONLINE EVENTS
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
                                                    child: ActivitiesOnlineEvent(
                                                      type: "0", // inperson events
                                                    )
                                                ),
                                            ));
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0.7, 0.7), // changes position of shadow
                                                  ),
                                                ],),
                                              child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                      height: 42,
                                                      padding: EdgeInsets.only(left: 5.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[400],
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:  Radius.circular(12.0),
                                                          bottomRight:  Radius.circular(12.0),
                                                        ),
                                                      ),
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text("Online Events",
                                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                        ),
                                                      )
                                                  )
                                              )
                                          ),
                                        ),

                                        //OFFERS
                                        Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0.7, 0.7), // changes position of shadow
                                                ),
                                              ],),
                                            child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                    height: 42,
                                                    padding: EdgeInsets.only(left: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[400],
                                                      borderRadius: BorderRadius.only(
                                                        bottomLeft:  Radius.circular(12.0),
                                                        bottomRight:  Radius.circular(12.0),
                                                      ),
                                                    ),
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text("Offers",
                                                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                      ),
                                                    )
                                                )
                                            )
                                        ),

                                        //INTERESTS
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>InterestScreen()));
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0.7, 0.7), // changes position of shadow
                                                  ),
                                                ],),
                                              child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                      height: 42,
                                                      padding: EdgeInsets.only(left: 5.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[400],
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:  Radius.circular(12.0),
                                                          bottomRight:  Radius.circular(12.0),
                                                        ),
                                                      ),
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text("Interests",
                                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                                        ),
                                                      )
                                                  )
                                              )
                                          ),
                                        ),


                                      ],
                                    )
                              ),
                            ),

                            //MESSAGES TAB
                            SingleChildScrollView(
                              child: Container(
                                child: Text(""),
                              ),
                            ),

                          ]))
                    ])
            ),

          );
        });
  }
}

