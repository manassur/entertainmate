import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:entertainmate/bloc/invite_user/invite_user_event.dart';
import 'package:entertainmate/bloc/invite_user/invite_user_state.dart';
import 'package:entertainmate/bloc/invite_user/inviter_user_bloc.dart';
import 'package:entertainmate/screens/model/invite_user_model.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAuthorizedUser extends StatefulWidget {

  @override
  _AddAuthorizedUserState createState() => _AddAuthorizedUserState();
}

class _AddAuthorizedUserState extends State<AddAuthorizedUser> {
  TextEditingController _inviterUserController= TextEditingController();

  InviteUserBloc inviteUserBloc;

  @override
  void initState() {
    super.initState();

    inviteUserBloc = BlocProvider.of<InviteUserBloc>(context);
    inviteUserBloc.add(FetchInviteUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Add an authorized user",
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
                              color: Colors.grey[200],
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
                          child: Container (
                            height: 50,
                            width: MediaQuery.of ( context ).size.width,
                            child: (
                                MaterialButton (
                                  elevation: 0,
                                  onPressed: () {
                                    // Navigator.pop(context);
                                    int count = 0;
                                    Navigator.of(context).popUntil((_) => count++ >= 2);// pops 2 screens backward
                                    Flushbar(
                                      message: "Access granted to users",
                                      icon: Icon(
                                        Icons.done,
                                        size: 28.0,
                                        color: Colors.white,
                                      ),
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.blue,
                                    )..show(context);
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
        physics: NeverScrollableScrollPhysics(),
        itemCount: inviteUserModel.followers.length,
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
                      // 'Noshat',
                      '${inviteUserModel.followers[userPos].name}',
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