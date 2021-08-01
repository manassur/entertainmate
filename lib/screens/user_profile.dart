import 'package:entertainmate/account_settings.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_event.dart';
import 'package:entertainmate/bloc/user_profile/user_profile_bloc.dart';
import 'package:entertainmate/bloc/user_profile/user_profile_event.dart';
import 'package:entertainmate/bloc/user_profile/user_profile_state.dart';
import 'package:entertainmate/screens/edit_profile.dart';
import 'package:entertainmate/screens/events_item.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'model/user_profile_model.dart';

class UserProfile extends StatefulWidget {
  String userId;

  UserProfile({@required this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserProfileBloc userProfileBloc;
  PostCommentBloc followUserBloc;

  @override
  void initState() {
    super.initState();
    userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    userProfileBloc.add(FetchUserProfileEvent(userId: widget.userId));

    followUserBloc = BlocProvider.of<PostCommentBloc>(context);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      backgroundColor: Colors.grey[200],
      appBar: AppBar (
        title: Text ( "User Profile", style: TextStyle ( color: Colors.grey ), ),
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Center(child: Text('Back', style: TextStyle(color: Colors.grey),)),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
        ],
      ),
      body: Container (
        child: BlocConsumer<UserProfileBloc, UserProfileState>(
          listener: (context, state){
            if ( state is UserProfileInitialState ) {

            } else if ( state is UserProfileLoadedState ) {

            }
            else if ( state is UserProfileFailureState ) {
              Fluttertoast.showToast(
                  msg: "Could not load user profile at this time",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          },
          builder:(context, state){
            if (state is UserProfileInitialState) {
              return buildLoading();
            } else if (state is UserProfileLoadingState) {
              return buildLoading();
            } else if (state is UserProfileLoadedState) {
              return buildUserProfile(state.userProfile);

            } else if (state is UserProfileFailureState) {
              return buildErrorUi(state.error);
            } else {
              return buildErrorUi("Something went wrong!");
            }

          },

        ),

      ),
    );

  }

  Widget buildUserProfile(UserProfileModel userProfileModel){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100)),
                  color: Colors.white

              ),
            ),
            Padding (
              padding: const EdgeInsets.only( top: 8.0 ),
              child: Center(
                child: Container (
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration (
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage (
                          Constant.IMAGE_BASE_URL+ '${userProfileModel.profilePhoto}',

                          // 'https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'
                        ),
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Padding (
            padding: const EdgeInsets.only( top: 8.0 ),
            child: Text (
              '${userProfileModel.name}',
              style: TextStyle (
              fontFamily: 'SF Pro',
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 25.0,
            ), ),
          ),
        ),
        Center(
          child: Text (
            '${userProfileModel.headline}',
            style: TextStyle (color: Colors.black, fontSize: 20.0,
          ), ),
        ),

        Row (
          children: [
            Padding (
              padding: const EdgeInsets.fromLTRB( 30.0, 10.0, 10.0, 0 ),
              child: Column (
                children: [
                  Text (
                    '1',
                    style: TextStyle (fontWeight: FontWeight.w700 ), ),
                  Text (
                    'Followers',
                    style: TextStyle (fontWeight: FontWeight.w700 ), ),
                ],
              ),
            ),
            Padding (
              padding: const EdgeInsets.fromLTRB( 30.0, 10.0, 10.0, 0 ),
              child: Column (
                children: [
                  Text (
                    '1',
                    style: TextStyle (fontWeight: FontWeight.w700 ), ),
                  Text (
                    'Following',
                    style: TextStyle (fontWeight: FontWeight.w700 ), ),
                ],
              ),
            ),
            Spacer ( ),

            Padding (
              padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 20.0, 0 ),
              child: RaisedButton (
                onPressed: (){
                  followUserBloc.add(FollowEvent(userId: userProfileModel.id,action: userProfileModel.relation.isFollowing));
                  setState(() {
                    if(userProfileModel.relation.isFollowing==0){
                      userProfileModel.relation.isFollowing=1;
                    }else{
                      userProfileModel.relation.isFollowing=0;

                    }
                  });

                },
                color:userProfileModel.relation.isFollowing==1?Colors.black87:Colors.grey[300],
                disabledColor: Colors.grey[400],
                child: Text ( userProfileModel.relation.isFollowing==1?' Following ':'    Follow   ',
                  style: TextStyle ( color: userProfileModel.relation.isFollowing==1?Colors.white:Colors.white ), ),
                shape: RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular ( 10.0 ),
                ),
              ),
            ),

          ],
        ),
        Divider ( ),
        Container (
          padding: EdgeInsets.fromLTRB ( 10, 20, 10, 15 ),
          width: double.maxFinite,
          child: Padding (
            padding: const EdgeInsets.fromLTRB( 20.0, 0.0, 20.0, 10.0 ),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text (
                  // '"@" username',
                  '${"@"+userProfileModel.username}',
                  style: TextStyle (
                  fontFamily: 'SF Pro',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),  ),
                SizedBox (
                  height: 10,
                ),
                Text ( '${userProfileModel.bio}',style:TextStyle (
                  fontFamily: 'SF Pro',
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ), ),
                Padding (
                  padding: const EdgeInsets.only( top: 30.0 ),
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset (
                        'images/005-instagram.svg', height: 20,
                        width: 15,
                        color: userProfileModel.link.instagram.isEmpty? Colors.grey: Colors.black87,
                      ),
                      SvgPicture.asset (
                        'images/004-twitter.svg', height: 20,
                        width: 15,
                        color: userProfileModel.link.twitter.isEmpty? Colors.grey: Colors.black87,
                      ),
                      SvgPicture.asset (
                        'images/003-facebook.svg', height: 20,
                        width: 15,
                        color: userProfileModel.link.facebook.isEmpty? Colors.grey: Colors.black87,
                      ),
                      SvgPicture.asset (
                        'images/002-linkedin-logo.svg', height: 20,
                        width: 15,
                        color: userProfileModel.link.linkedin.isEmpty? Colors.grey: Colors.black87,
                      ),
                      SvgPicture.asset ( 'images/001-email.svg', height: 20,
                        width: 15,
                        color: userProfileModel.link.email.isEmpty? Colors.grey: Colors.black87,

                        // color:data.user.email.isNotEmpty?Colors.black87: Colors.grey,
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider ( ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all ( 10 ),
              child: Text ( "Events Organized",
                style: TextStyle (
                  fontFamily: 'SF Pro',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ), ),),
          ],
        ),
        Spacer ( ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EventsItem(eventName: "Social",),
                  EventsItem(eventName: "Sports",),

                ],
              ),
            ],
          ),
        )


      ],
    );

  }


  Widget buildLoading ( ) {
    return Center (
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: CircularProgressIndicator ( ),
      ) ,
    );
  }

  Widget buildErrorUi ( String message ) {
    return Center (
      child: Text ( message , style: TextStyle ( color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );
  }
}
