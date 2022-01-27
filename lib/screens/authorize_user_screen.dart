import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:entertainmate/bloc/invite_user/invite_user_event.dart';
import 'package:entertainmate/bloc/invite_user/invite_user_state.dart';
import 'package:entertainmate/bloc/invite_user/inviter_user_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_event.dart';
import 'package:entertainmate/bloc/send_invite/send_invite_event.dart';
import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:entertainmate/screens/utility/constants.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/invite_user_model.dart';

class AuthorizeUserScreen extends StatefulWidget {

  String screen, id;

  AuthorizeUserScreen({Key key, @required this.screen, this.id}) : super(key: key);


  @override
  _AuthorizeUserScreenState createState() => _AuthorizeUserScreenState();

}

class _AuthorizeUserScreenState extends State<AuthorizeUserScreen> {
  TextEditingController _inviterUserController= TextEditingController();

  InviteUserBloc inviteUserBloc;
  PostCommentBloc postCommentBloc;

  // selected position of the busness creator
  int selectedPosition=0;
  String selectedPositionName='Manager/Ceo';

  //selected user to be invited or authorized
  Followers selectedUser;



  // bool isSelected = false;

  @override
  void initState() {
    super.initState();

    inviteUserBloc = BlocProvider.of<InviteUserBloc>(context);
    postCommentBloc = BlocProvider.of<PostCommentBloc>(context);
    inviteUserBloc.add(FetchInviteUserEvent(screen: widget.screen, id: widget.id));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.screen,
          style: TextStyle(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.center,),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            BlocListener <InviteUserBloc, InviteUserState>(
              listener: (context, state){
                if ( state is InviteUserInitialState ) {

                } else if ( state is InviteUserLoadedState ) {

                } else if (state is InviteUserEmptyState){
                  Text('');
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
                    return Column(
                      children: [
                        SizedBox(height: 20),
                        Container (
                            padding: const EdgeInsets.all( 10),
                            margin: const EdgeInsets.all( 10),
                            height: 50,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular ( 5.0 ),
                              color: Colors.grey[100],
                            ),
                            width: MediaQuery.of ( context ).size.width,
                            child: TextField (
                              controller: _inviterUserController,
                              onSubmitted: (value){

                              },
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
                        buildUserFollowingList ( state.inviteUser),
                        Padding (
                          padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 0.0 ),
                          child:  Container (
                            height: 40,
                            margin:  EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 10.0 ),
                            width: MediaQuery.of ( context ).size.width,
                            child: (
                                MaterialButton (
                                  elevation: 0,
                                  onPressed: () async{


                                    if(selectedUser!=null)
                                  {  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                      ),
                                      isScrollControlled: true,
                                      backgroundColor: Colors.white,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                              return FractionallySizedBox(
                                                  heightFactor: 0.6,
                                                  child:  Padding(
                                                    padding: const EdgeInsets.all(25.0),
                                                    child: Container (
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Center(child: Text(selectedUser.name+"'s position at this business", style: TextStyle(fontSize: 17),)),
                                                          Divider(),
                                                          GestureDetector(
                                                            onTap: (){
                                                              setState(() {
                                                                selectedPosition=0;
                                                                selectedPositionName='Owner/CEO';
                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Owner/CEO",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                                    Text("Own the business",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                CircleAvatar(
                                                                  backgroundColor: Colors.black87,
                                                                  radius: 14,
                                                                  child: CircleAvatar(
                                                                      backgroundColor: Colors.white,
                                                                      radius: 13,
                                                                      child: CircleAvatar(
                                                                        backgroundColor:   selectedPosition==0?Colors.blueAccent:Colors.white,
                                                                        radius: 10,

                                                                      )
                                                                  ),

                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 25),

                                                          GestureDetector(
                                                            onTap: (){
                                                              setState(() {
                                                                selectedPosition=1;
                                                                selectedPositionName='Manager';
                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Manager ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                                    Text("Manage the business ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                CircleAvatar(
                                                                  backgroundColor: Colors.black87,
                                                                  radius: 14,
                                                                  child: CircleAvatar(
                                                                      backgroundColor: Colors.white,
                                                                      radius: 13,
                                                                      child: CircleAvatar(
                                                                        backgroundColor: selectedPosition==1?Colors.blueAccent:Colors.white,
                                                                        radius: 10,

                                                                      )
                                                                  ),

                                                                )
                                                              ],
                                                            ),
                                                          ),

                                                          SizedBox(height: 25),

                                                          GestureDetector(
                                                            onTap: (){
                                                              setState(() {
                                                                selectedPosition=2;
                                                                selectedPositionName='Employee';
                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Employee ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                                    Text("Work at the business",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                CircleAvatar(
                                                                  backgroundColor: Colors.black87,
                                                                  radius: 14,
                                                                  child: CircleAvatar(
                                                                      backgroundColor: Colors.white,
                                                                      radius: 13,
                                                                      child: CircleAvatar(
                                                                        backgroundColor: selectedPosition==2?Colors.blueAccent:Colors.white,
                                                                        radius: 10,

                                                                      )
                                                                  ),

                                                                )
                                                              ],
                                                            ),
                                                          ),

                                                          SizedBox(height: 25),

                                                          GestureDetector(
                                                            onTap: (){
                                                              setState(() {
                                                                selectedPosition=3;
                                                                selectedPositionName='Others';

                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Others ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                                    Text("Any other position not listed above",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                CircleAvatar(
                                                                  backgroundColor: Colors.black87,
                                                                  radius: 14,
                                                                  child: CircleAvatar(
                                                                      backgroundColor: Colors.white,
                                                                      radius: 13,
                                                                      child: CircleAvatar(
                                                                        backgroundColor: selectedPosition==3?Colors.blueAccent:Colors.white,
                                                                        radius: 10,

                                                                      )
                                                                  ),

                                                                )
                                                              ],
                                                            ),
                                                          ),

                                                          SizedBox(height: 25),

                                                          Divider(),
                                                          Spacer(),

                                                          GestureDetector(
                                                            onTap: () async {
                                                              postCommentBloc.add(AssignUserBusinessRoleEvent(userId: selectedUser.id,busId:widget.id , role:selectedPosition.toString(),action: 'add'));
                                                              Navigator.of(context).pop();

                                                               await Flushbar(
                                                                message: selectedPositionName+" position now assigned to "+selectedUser.name,
                                                                duration: Duration(seconds: 2),
                                                              ).show(context).then((value) => (){

                                                               });

                                                            },

                                                            child: Container(
                                                              height: 50,
                                                              width: double.infinity,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.blueAccent,
                                                                  borderRadius: BorderRadius.circular(8)
                                                              ),
                                                              child: Center(
                                                                child: Text("Continue",
                                                                    style: TextStyle( fontSize: 17, color: Colors.white,fontWeight: FontWeight.w500  )),
                                                              ),

                                                            ),
                                                          ),
                                                          SizedBox(height: 15),

                                                        ],
                                                      ),

                                                    ),
                                                  )
                                              );

                                            });
                                      },
                                    );}else{
                                      // just show a invite success jare
                                      await Flushbar(
                                            message: 'Please select a user',
                                            duration: Duration(seconds: 3),
                                          ).show(context);
                                    }

                                  },

                                  color: Colors.blueAccent,
                                  // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                                  child: Text ( 'Continue',
                                    style: TextStyle ( color: Colors.white ), ),
                                  shape: RoundedRectangleBorder (
                                    borderRadius: BorderRadius.circular ( 5.0 ),
                                  ),
                                )
                            ),
                          ),

                        ),
                      ],
                    );
                  } else if ( state is InviteUserFailureState ) {
                    return buildErrorUi ( state.error );
                  } else if (state is InviteUserEmptyState){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 60.0),
                      child: Center(child: Text(state.message)),
                    );
                  }
                  else {
                    return buildErrorUi ( "Something went wrong!" );
                  }
                },
              ),

            ),



          ],
        ),
      ),
    );

  }

  Widget buildUserFollowingList(InviteUserModel inviteUserModel){
   return Container(
     height: 400,
      child: GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0),
        shrinkWrap: true,
        itemCount: inviteUserModel.followers.length,
        // itemCount:  10,
        itemBuilder: (ctx, userPos) {
          return Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedUser=inviteUserModel.followers[userPos];
                  inviteUserModel.followers.forEach((element) {element.isSelected=false;});
                  inviteUserModel.followers[userPos].isSelected = true;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
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
                            // 'https://jooinn.com/images/girl-174.jpg',
                              Constant.IMAGE_BASE_URL+ '${inviteUserModel.followers[userPos].icon}',
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

                      Icon(Icons.done,color: inviteUserModel.followers[userPos].isSelected ? Colors.white:Colors.transparent)

                ]
                  ),

                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      '${inviteUserModel.followers[userPos].name}',
                        textAlign:TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold, fontSize: 10),
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