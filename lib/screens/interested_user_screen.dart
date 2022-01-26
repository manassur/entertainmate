import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:entertainmate/bloc/interested_user/interested_user_bloc.dart';
import 'package:entertainmate/bloc/interested_user/interested_user_event.dart';
import 'package:entertainmate/bloc/interested_user/interested_user_state.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_bloc.dart';
import 'package:entertainmate/bloc/save_interest/save_interest_event.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'model/InterestedUserModel.dart';
import 'model/user.dart';
import 'repository/repository.dart';

class InterestedUserScreen extends StatefulWidget {
String userId;
String action;
String actor;
String postId;
InterestedUserScreen({@required this.userId,this.action,this.actor,this.postId});
  @override
  _InterestedUserScreenState createState() => _InterestedUserScreenState();
}

class _InterestedUserScreenState extends State<InterestedUserScreen> {
  InterestedUserBloc interestedUserBloc;
  InterestedUserModel interestedUserModel;
  SaveInterestBloc saveInterestBloc;
  Repository repository;
  User currentUser;


  @override
  void initState() {
    super.initState();
    interestedUserBloc = BlocProvider.of<InterestedUserBloc>(context);
    interestedUserBloc.add(FetchInterestedUserEvent(userId: widget.userId));
    saveInterestBloc = BlocProvider.of<SaveInterestBloc>(context);
    print(' action :'+ widget.action + ' actor : '+widget.actor);

    repository = Repository();
    repository.getCurrentUser().then((valuee) =>   {
      setState(() {
        currentUser= valuee;
      }),
    },);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InterestedUserBloc, InterestedUserState>(
      listener: (content, state){
        if (state is InterestedUserLoadedState) {
          // a message will only come when it is updating the feed.
        }
        else if (state is InterestedUserFailureState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                "Could not load users  at this time"),));
        }
      },
      child: BlocBuilder<InterestedUserBloc, InterestedUserState>(
        builder: (context, state) {
          if (state is InterestedUserInitialState) {
            return buildLoading();
          } else if (state is InterestedUserLoadingState) {
            return buildLoading();
          } else if (state is InterestedUserLoadedState) {
            return dialogBox(state.interestedUser);
          } else if (state is InterestedUserFailureState) {
            return buildErrorUi(state.error);
          }
          else {
            return buildErrorUi("Something went wrong!");
          }
        },
      ),
    );
  }

  Widget dialogBox (InterestedUserModel interestedUserModel){

    return Container(
      padding: EdgeInsets.only(left: 15, right: 15.0, bottom: 10.0,top: 20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Center(
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: NetworkImage(
                      // 'https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'
                    Constant.IMAGE_BASE_URL+ '${interestedUserModel.profilePhoto}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(
              '${interestedUserModel.name}',
              // "Fei Lu",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
          ),
          Center(
            child: Text(
              // "Description is empty",
              '${interestedUserModel.description}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,),
          ),
          SizedBox(height: 6,),
          Divider(color: Colors.grey[300],),
          SizedBox(height: 7,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             SvgPicture.asset('images/005-instagram.svg',height: 25,width:25),
              SvgPicture.asset('images/004-twitter.svg',height: 25,width:25),
              SvgPicture.asset('images/003-facebook.svg',height: 25,width:25),
              SvgPicture.asset('images/002-linkedin-logo.svg',height: 25,width:25),

            ],
          ),

          SizedBox(height: 20,),


          if(widget.action=='going'&& ( widget.actor=='moderator'))
            Row(
              children: [
                Container(
                    height: 50,

                    padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
                    child: MaterialButton (
                      elevation: 0,
                      onPressed: () {
                        saveInterestBloc.add(UpdateLikeEvent(
                            postId: widget.postId,
                            userId: widget.userId,
                            type: "2",
                            action: "1"));
                        Navigator.pop(context,{
                          "action": "interested",
                          "userId": widget.userId,
                        });
                        Flushbar(
                          message: "Removed from going",
                          icon: Icon(
                            Icons.done,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.redAccent,
                        )..show(context);
                      },
                      color: Colors.white,
                      // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                      child: Text ( 'Remove from going',
                        style: TextStyle ( color: Colors.redAccent ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 5.0 ),
                          side: BorderSide(color: Colors.redAccent, width: 2.0)

                      ),
                    )
                ),
                SizedBox(width:10),
                Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
                    child: MaterialButton (
                      elevation: 0,
                      onPressed: () {
                        saveInterestBloc.add(UpdateLikeEvent(
                            postId: widget.postId,
                            userId: widget.userId,
                            type: "4",
                            action: "1"));
                        Navigator.pop(context,{
                          "action": "moderate",
                          "userId": widget.userId,
                        });
                        Flushbar(
                          message: "Moved to moderating",
                          icon: Icon(
                            Icons.done,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.blueAccent,
                        )..show(context);
                      },
                      color: Colors.blueAccent,
                      // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                      child: Text ( 'Start moderating',
                        style: TextStyle ( color: Colors.white ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 5.0 ),
                      ),
                    )
                ),

              ],
            ),
          if(widget.action=='moderating'&& (widget.actor=='author'))
           currentUser.id!=widget.userId?Container(
                height: 50,
                width: MediaQuery.of(context).size.width,

                padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
                child: MaterialButton (
                  elevation: 0,
                  onPressed: () {
                    saveInterestBloc.add(UpdateLikeEvent(
                        postId: widget.postId,
                        userId: widget.userId,
                        type: "3",
                        action: "1"));
                    Navigator.pop(context,  {
                      "action": "resign",
                      "userId": widget.userId,
                    },);
                    Flushbar(
                      message: "Resigned from moderating",
                      icon: Icon(
                        Icons.done,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.redAccent,
                    )..show(context);
                  },
                  color: Colors.white,

                  // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                  child: Text ( 'Resign moderating',
                    style: TextStyle ( color: Colors.redAccent ), ),
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular ( 5.0 ),
                      side: BorderSide(color: Colors.redAccent, width: 2.0)
                  ),
                )
            ):Container(),
          if(widget.action=='interested'&& (widget.actor=='moderator'))
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width,

                padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
                child: MaterialButton (
                  elevation: 0,
                  onPressed: () {
                    saveInterestBloc.add(UpdateLikeEvent(
                        postId: widget.postId,
                        userId: widget.userId,
                        type: "3",
                        action: "1"));
                    Navigator.pop(context,{
                      "action": "going",
                      "userId": widget.userId,
                    });
                    Flushbar(
                      message: "Moved to going",
                      icon: Icon(
                        Icons.done,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.blueAccent,
                    )..show(context);
                  },
                  color: Colors.blueAccent,
                  // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                  child: Text ( 'Move to going',
                    style: TextStyle ( color: Colors.white ), ),
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular ( 5.0 ),
                  ),
                )
            ),

          SizedBox(height: 10,),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
              child: MaterialButton (
                elevation: 0,
                onPressed: () {},
                color: Colors.grey.shade200,

                // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                child: Text ( 'View full profile',
                  style: TextStyle ( color: Colors.black ), ),
                shape: RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular ( 5.0 ),
                ),
              )
          ),
        ],
      ),
    );

  }



  Widget buildLoading ( ) {
    return Center (
      child: CircularProgressIndicator ( ) ,
    );
  }

  Widget buildErrorUi ( String message ) {
    return Center (
      child: Text ( message , style: TextStyle ( color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );
  }
}