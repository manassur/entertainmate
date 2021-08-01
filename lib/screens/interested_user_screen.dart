import 'dart:ui';
import 'package:entertainmate/bloc/interested_user/interested_user_bloc.dart';
import 'package:entertainmate/bloc/interested_user/interested_user_event.dart';
import 'package:entertainmate/bloc/interested_user/interested_user_state.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/InterestedUserModel.dart';

class InterestedUserScreen extends StatefulWidget {
String userId;
InterestedUserScreen({@required this.userId});
  @override
  _InterestedUserScreenState createState() => _InterestedUserScreenState();
}

class _InterestedUserScreenState extends State<InterestedUserScreen> {
  InterestedUserBloc interestedUserBloc;
  InterestedUserModel interestedUserModel;

  @override
  void initState() {
    super.initState();
    interestedUserBloc = BlocProvider.of<InterestedUserBloc>(context);
    interestedUserBloc.add(FetchInterestedUserEvent(userId: widget.userId));
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

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15.0, bottom: 10.0),
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
                Icon(Icons.facebook),
                Icon(Icons.mail),
                Icon(Icons.settings),
                Icon(Icons.facebook),
                Icon(Icons.mail),

              ],
            ),

            SizedBox(height: 20,),

            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
             child: MaterialButton (
               elevation: 0,
               onPressed: () {},
               color: Colors.grey.shade200,
               // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
               child: Text ( 'Invite',
                 style: TextStyle ( color: Colors.grey ), ),
               shape: RoundedRectangleBorder (
                 borderRadius: BorderRadius.circular ( 5.0 ),
               ),
             )
            ),


          ],
        ),
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