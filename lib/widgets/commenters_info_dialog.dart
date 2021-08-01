import 'dart:ui';
import 'package:entertainmate/bloc/user_comment/user_comment_bloc.dart';
import 'package:entertainmate/bloc/user_comment/user_comment_event.dart';
import 'package:entertainmate/bloc/user_comment/user_comment_state.dart';
import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:entertainmate/screens/utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentersInfo extends StatefulWidget {
String postId;
  CommentersInfo({@required this.postId});

  @override
  _CommentersInfoState createState() => _CommentersInfoState();
}

class _CommentersInfoState extends State<CommentersInfo> {
  UserCommentBloc userCommentBloc;
  // UserCommentModel userCommentModel;

  @override
  void initState() {
    super.initState();
    userCommentBloc = BlocProvider.of<UserCommentBloc>(context);
    userCommentBloc.add(FetchUserCommentEvent(postId: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCommentBloc, UserCommentState>(
      listener: (content, state){
      if (state is UserCommentLoadedState &&
            state.message != null) {
          // a message will only come when it is updating the feed.
        }
        else if (state is UserCommentFailureState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                "Could not load comments  at this time"),));
        }
      },
      child: BlocBuilder<UserCommentBloc, UserCommentState>(
        builder: (context, state) {
          if (state is UserCommentInitialState) {
            return buildLoading();
          } else if (state is UserCommentLoadingState) {
            return buildLoading();
          } else if (state is UserCommentLoadedState) {
            return dialogBox(state.userComment);
          } else if (state is UserCommentFailureState) {
            return buildErrorUi(state.error);
          }
          else {
            return buildErrorUi("Something went wrong!");
          }
        },
      ),
    );

    // return Dialog(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   elevation: 0,
    //   backgroundColor: Colors.transparent,
    //   child: Container(
    //     padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
    //     decoration: BoxDecoration(
    //       shape: BoxShape.rectangle,
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(15.0),
    //     ),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         SizedBox(height: 10,),
    //         Center(
    //           child: Container(
    //             height: 80,
    //             width: 90,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(35.0),
    //               image: DecorationImage(
    //                 image: NetworkImage(
    //                     'https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 10,),
    //         Center(
    //           child: Text(
    //             "Fei Lu",
    //             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
    //         ),
    //         SizedBox(height: 5,),
    //         Center(
    //           child: Text("Postdoc at the university of Texas",
    //             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
    //             textAlign: TextAlign.center,),
    //         ),
    //         SizedBox(height: 10,),
    //         Divider(color: Colors.grey[300],),
    //         SizedBox(height: 10,),
    //
    //         Container(
    //           width: MediaQuery.of(context).size.width,
    //           padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
    //           decoration: BoxDecoration(
    //               shape: BoxShape.rectangle,
    //               color: Colors.lightBlueAccent.withOpacity(0.1),
    //               borderRadius: BorderRadius.circular(10.0),
    //               border: Border.all(
    //                   color: Colors.lightBlueAccent.withOpacity(0.15))
    //
    //           ),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Row(
    //                 children: [
    //                   Text(
    //                     'commenters username',
    //                     // '${userCommentModel.comments[0].username}',
    //                     style: TextStyle(color: Colors.grey[700],
    //                         fontSize: 17,
    //                         fontWeight: FontWeight.w700),),
    //                   Spacer(),
    //                   Icon(Icons.more_horiz, color: Colors.grey[800])
    //                 ],
    //               ),
    //               Text(
    //                 'comment time',
    //                 // Constants.formattedTime(userCommentModel.comments[0].creation),
    //                 style: TextStyle(fontSize: 12, color: Colors.grey[500]),
    //                 textAlign: TextAlign.center,),
    //               SizedBox(height: 15,),
    //
    //               Text(
    //                 'comment content',
    //                 // '${userCommentModel.comments[0].content}',
    //                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.grey[600]),
    //               ),
    //               SizedBox(height: 10,),
    //               Row(
    //                 children: [
    //                   Icon(Icons.thumb_up_alt_outlined, color: Colors.grey[500],),
    //                   Padding(
    //                     padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
    //                     child: Text("12",
    //                       style: TextStyle(color: Colors.grey[500]),),
    //                   ),
    //                   Icon(Icons.thumb_down_alt_outlined, color: Colors
    //                       .grey[500],),
    //                   Padding(
    //                     padding: const EdgeInsets.only(left: 5.0),
    //                     child: Text("3",
    //                         style: TextStyle(color: Colors.grey[500])),
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //
    //         SizedBox(height: 20,),
    //         Text("Show 2 more replies",
    //           style: TextStyle(fontSize: 14, color: Colors.grey[600]),),
    //         SizedBox(height: 13,),
    //
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               height: 35,
    //               width: 35,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10.0),
    //                 image: DecorationImage(
    //                   image: NetworkImage(
    //                       'https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(width: 10.0,),
    //             Expanded(
    //               child: Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
    //                 decoration: BoxDecoration(
    //                     shape: BoxShape.rectangle,
    //                     color: Colors.grey.withOpacity(0.1),
    //                     borderRadius: BorderRadius.circular(10.0),
    //                     border: Border.all(color: Colors.grey.withOpacity(0.15))
    //                 ),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Row(
    //                       children: [
    //                         Text(
    //                           // '${userCommentModel.comments[0].replies[0].username}',
    //                           "Ehsan Doostdar",
    //                           style: TextStyle(color: Colors.grey[700],
    //                               fontSize: 17,
    //                               fontWeight: FontWeight.w700),),
    //                         Spacer(),
    //                         Icon(
    //                             Icons.more_horiz, color: Colors.grey[700])
    //                       ],
    //                     ),
    //                     Text(
    //                       // Constants.formattedTime(userCommentModel.comments[0].replies[0].creation),
    //                       "June 3, 2021  1:30 PM",
    //                       style: TextStyle(
    //                           fontSize: 12, color: Colors.grey[500]),
    //                       textAlign: TextAlign.center,),
    //                     SizedBox(height: 15,),
    //
    //                     Text(
    //                       // '${userCommentModel.comments[0].replies[0].content}',
    //                       "Postdoc at the Texas of some Postdoc at the university of Texas Postdoc at the Texas university of Texas.",
    //                       style: TextStyle(fontWeight: FontWeight.w500,
    //                           fontSize: 15,
    //                           color: Colors.grey[600]),
    //                     ),
    //                     SizedBox(height: 10,),
    //                     Row(
    //                       children: [
    //                         Icon(Icons.thumb_up_alt_outlined,
    //                           color: Colors.grey[500],),
    //                         Padding(
    //                           padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
    //                           child: Text("2", style: TextStyle(
    //                               color: Colors.grey[500]),),
    //                         ),
    //                         Icon(Icons.thumb_down_alt_outlined,
    //                           color: Colors.grey[500],),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 5.0),
    //                           child: Text(" ", style: TextStyle(
    //                               color: Colors.grey[500])),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //
    //       ],
    //     ),
    //   ),
    // );

  }

  Widget dialogBox (UserCommentModel userCommentModel){

          // return Container(height: 50, color: Colors.green,);
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
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
                      height: 80,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      "Fei Lu",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: Text("Postdoc at the university of Texas",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey[300],),
                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.lightBlueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.lightBlueAccent.withOpacity(0.15))

                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              '${userCommentModel.comments[0].username}',
                              style: TextStyle(color: Colors.grey[700],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),),
                            Spacer(),
                            Icon(Icons.more_horiz, color: Colors.grey[800])
                          ],
                        ),
                        Text(
                          Constants.formattedTime(userCommentModel.comments[0].creation),
                          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          textAlign: TextAlign.center,),
                        SizedBox(height: 15,),

                        Text(
                          '${userCommentModel.comments[0].content}',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined, color: Colors.grey[500],),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
                              child: Text("12",
                                style: TextStyle(color: Colors.grey[500]),),
                            ),
                            Icon(Icons.thumb_down_alt_outlined, color: Colors
                                .grey[500],),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("3",
                                  style: TextStyle(color: Colors.grey[500])),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),
                  Text("Show 2 more replies",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),),
                  SizedBox(height: 13,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey.withOpacity(0.15))
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    '${userCommentModel.comments[0].replies[0].username}',
                                    // "Ehsan Doostdar",
                                    style: TextStyle(color: Colors.grey[700],
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),),
                                  Spacer(),
                                  Icon(
                                      Icons.more_horiz, color: Colors.grey[700])
                                ],
                              ),
                              Text(
                                Constants.formattedTime(userCommentModel.comments[0].replies[0].creation),
                                // "June 3, 2021  1:30 PM",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[500]),
                                textAlign: TextAlign.center,),
                              SizedBox(height: 15,),

                              Text(
                                '${userCommentModel.comments[0].replies[0].content}',
                                // "Postdoc at the Texas of some Postdoc at the university of Texas Postdoc at the Texas university of Texas.",
                                style: TextStyle(fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.grey[600]),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.thumb_up_alt_outlined,
                                    color: Colors.grey[500],),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
                                    child: Text("2", style: TextStyle(
                                        color: Colors.grey[500]),),
                                  ),
                                  Icon(Icons.thumb_down_alt_outlined,
                                    color: Colors.grey[500],),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(" ", style: TextStyle(
                                        color: Colors.grey[500])),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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