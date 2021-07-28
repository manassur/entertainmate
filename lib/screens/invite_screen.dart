import 'dart:ui';
import 'package:entertainmate/bloc/invite_user/invite_user_event.dart';
import 'package:entertainmate/bloc/invite_user/invite_user_state.dart';
import 'package:entertainmate/bloc/invite_user/inviter_user_bloc.dart';
import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:entertainmate/screens/utility/constants.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/invite_user_model.dart';

class InviteScreen extends StatefulWidget {

  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  TextEditingController _inviterUserController= TextEditingController();

  InviteUserBloc inviteUserBloc;

  // bool isSelected = false;

  @override
  void initState() {
    super.initState();

    inviteUserBloc = BlocProvider.of<InviteUserBloc>(context);
    inviteUserBloc.add(FetchInviteUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,

      child: Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
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
            SizedBox(height: 10),
            Center(
              child: Text("Invite a friend to this event",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,),
            ),
            SizedBox(height: 2,),
            Divider(color: Colors.grey[300],),
            SizedBox(height: 10,),

            Padding (
              padding: const EdgeInsets.fromLTRB( 0.0, 0.0, 0.0, 20.0 ),
              child: Container (
                  height: 35,
                  decoration: BoxDecoration (
                    borderRadius: BorderRadius.circular ( 5.0 ),
                    color: Colors.grey[100],
                  ),
                  width: MediaQuery.of ( context ).size.width,
                  child: TextField (
                    controller: _inviterUserController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration (
                        counterText: "",
                        border: InputBorder.none,
                        prefixIcon: Icon ( Icons.search ),
                        hintText: 'Search here',
                        hintStyle: TextStyle (
                            color: Colors.grey, fontSize: 15 )
                    ),
                    onChanged: ( value ) {
                      // data.setDescription(value);
                    },
                  )
              ),
            ),

            BlocListener <InviteUserBloc, InviteUserState>(
              listener: (context, state){
                if ( state is InviteUserInitialState ) {

                } else if ( state is InviteUserLoadedState ) {

                }

                else if ( state is InviteUserFailureState ) {
                  Fluttertoast.showToast(
                      msg: "Could not load users",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              },

              child: BlocBuilder<InviteUserBloc, InviteUserState>(
                builder: (context, state) {
                  if ( state is InviteUserInitialState ) {
                    return buildLoading ( );
                  } else if ( state is InviteUserLoadingState ) {
                    return buildLoading ( );
                  } else if ( state is InviteUserLoadedState ) {
                    return buildUserFollowingList ( state.inviteUser);
                  } else if ( state is InviteUserFailureState ) {
                    return buildErrorUi ( state.error );
                  }
                  else {
                    return buildErrorUi ( "Something went wrong!" );
                  }
                },
              ),

            ),


            Padding (
              padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 0.0 ),
              child: Container (
                  height: 35,
                  width: MediaQuery.of ( context ).size.width,
                  child: (
                  MaterialButton (
                    elevation: 0,
                    onPressed: () {},
                    color: Colors.lightBlueAccent.shade100,
                    // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                    child: Text ( 'Invite',
                      style: TextStyle ( color: Colors.grey ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 5.0 ),
                    ),
                  )
              ),
            ),
            ),
          ],
        ),
      ),
    );

  }

  Widget buildUserFollowingList(InviteUserModel inviteUserModel){
   return Container(
      height: 350,
      child: GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0),
        shrinkWrap: true,
        itemCount: inviteUserModel.followers.length,
        // itemCount:  10,
        itemBuilder: (ctx, userPos) {
          return Container(
            child: GestureDetector(
              onTap: () {
                if(inviteUserModel.followers.any((item) =>item.isSelected)){
                  setState(() {
                    inviteUserModel.followers[userPos].isSelected = !inviteUserModel.followers[userPos].isSelected;
                  });
                } else{
                  setState(() {
                    inviteUserModel.followers[userPos].isSelected = true;
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration:
                      BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://jooinn.com/images/girl-174.jpg',
                            //   Constant.IMAGE_BASE_URL+ '${inviteUserModel.followers[userPos].icon}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: inviteUserModel.followers[userPos].isSelected ?
                          Colors.black54 : Colors.transparent,
                        ),
                      ),

                ]
                  ),

                  Center(
                    child: Text(
                      'Noshat',
                      // '${inviteUserModel.followers[userPos].name}',
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );

  }

  // Widget dialogBox (UserCommentModel userCommentModel){
  //
  //   // return Container(height: 50, color: Colors.green,);
  //   return Dialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //     elevation: 0,
  //     backgroundColor: Colors.transparent,
  //     child: Container(
  //       padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
  //       decoration: BoxDecoration(
  //         shape: BoxShape.rectangle,
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(15.0),
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           SizedBox(height: 10,),
  //           Center(
  //             child: Container(
  //               height: 80,
  //               width: 90,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(35.0),
  //                 image: DecorationImage(
  //                   image: NetworkImage(
  //                       'https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10,),
  //           Center(
  //             child: Text(
  //               "Fei Lu",
  //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
  //           ),
  //           SizedBox(height: 5,),
  //           Center(
  //             child: Text("Postdoc at the university of Texas",
  //               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
  //               textAlign: TextAlign.center,),
  //           ),
  //           SizedBox(height: 10,),
  //           Divider(color: Colors.grey[300],),
  //           SizedBox(height: 10,),
  //
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
  //             decoration: BoxDecoration(
  //                 shape: BoxShape.rectangle,
  //                 color: Colors.lightBlueAccent.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(10.0),
  //                 border: Border.all(
  //                     color: Colors.lightBlueAccent.withOpacity(0.15))
  //
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Row(
  //                   children: [
  //                     Text(
  //                       '${userCommentModel.comments[0].username}',
  //                       style: TextStyle(color: Colors.grey[700],
  //                           fontSize: 17,
  //                           fontWeight: FontWeight.w700),),
  //                     Spacer(),
  //                     Icon(Icons.more_horiz, color: Colors.grey[800])
  //                   ],
  //                 ),
  //                 Text(
  //                   Constants.formattedTime(userCommentModel.comments[0].creation),
  //                   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
  //                   textAlign: TextAlign.center,),
  //                 SizedBox(height: 15,),
  //
  //                 Text(
  //                   '${userCommentModel.comments[0].content}',
  //                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.grey[600]),
  //                 ),
  //                 SizedBox(height: 10,),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.thumb_up_alt_outlined, color: Colors.grey[500],),
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
  //                       child: Text("12",
  //                         style: TextStyle(color: Colors.grey[500]),),
  //                     ),
  //                     Icon(Icons.thumb_down_alt_outlined, color: Colors
  //                         .grey[500],),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 5.0),
  //                       child: Text("3",
  //                           style: TextStyle(color: Colors.grey[500])),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //
  //           SizedBox(height: 20,),
  //           Text("Show 2 more replies",
  //             style: TextStyle(fontSize: 14, color: Colors.grey[600]),),
  //           SizedBox(height: 13,),
  //
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 height: 35,
  //                 width: 35,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                   image: DecorationImage(
  //                     image: NetworkImage(
  //                         'https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 10.0,),
  //               Expanded(
  //                 child: Container(
  //                   width: MediaQuery.of(context).size.width,
  //                   padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
  //                   decoration: BoxDecoration(
  //                       shape: BoxShape.rectangle,
  //                       color: Colors.grey.withOpacity(0.1),
  //                       borderRadius: BorderRadius.circular(10.0),
  //                       border: Border.all(color: Colors.grey.withOpacity(0.15))
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: <Widget>[
  //                       Row(
  //                         children: [
  //                           Text(
  //                             '${userCommentModel.comments[0].replies[0].username}',
  //                             // "Ehsan Doostdar",
  //                             style: TextStyle(color: Colors.grey[700],
  //                                 fontSize: 17,
  //                                 fontWeight: FontWeight.w700),),
  //                           Spacer(),
  //                           Icon(
  //                               Icons.more_horiz, color: Colors.grey[700])
  //                         ],
  //                       ),
  //                       Text(
  //                         Constants.formattedTime(userCommentModel.comments[0].replies[0].creation),
  //                         // "June 3, 2021  1:30 PM",
  //                         style: TextStyle(
  //                             fontSize: 12, color: Colors.grey[500]),
  //                         textAlign: TextAlign.center,),
  //                       SizedBox(height: 15,),
  //
  //                       Text(
  //                         '${userCommentModel.comments[0].replies[0].content}',
  //                         // "Postdoc at the Texas of some Postdoc at the university of Texas Postdoc at the Texas university of Texas.",
  //                         style: TextStyle(fontWeight: FontWeight.w500,
  //                             fontSize: 15,
  //                             color: Colors.grey[600]),
  //                       ),
  //                       SizedBox(height: 10,),
  //                       Row(
  //                         children: [
  //                           Icon(Icons.thumb_up_alt_outlined,
  //                             color: Colors.grey[500],),
  //                           Padding(
  //                             padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
  //                             child: Text("2", style: TextStyle(
  //                                 color: Colors.grey[500]),),
  //                           ),
  //                           Icon(Icons.thumb_down_alt_outlined,
  //                             color: Colors.grey[500],),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 5.0),
  //                             child: Text(" ", style: TextStyle(
  //                                 color: Colors.grey[500])),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //   );
  //
  // }



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