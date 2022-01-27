import 'package:another_flushbar/flushbar.dart';
import 'package:entertainmate/bloc/invite_user/inviter_user_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_event.dart';
import 'package:entertainmate/bloc/user_business/user_business_bloc.dart';
import 'package:entertainmate/bloc/user_business/user_business_event.dart';
import 'package:entertainmate/bloc/user_business/user_business_state.dart';
import 'package:entertainmate/screens/authorize_user_screen.dart';
import 'package:entertainmate/screens/invite_screen.dart';
import 'package:entertainmate/screens/model/businessModel.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/utility/constants.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:entertainmate/widgets/business_position_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessVerifiedWidget extends StatefulWidget {

  String status;
  BusinessVerifiedWidget({this.status});
  @override
  _BusinessVerifiedWidgetState createState() => _BusinessVerifiedWidgetState();
}

class _BusinessVerifiedWidgetState extends State<BusinessVerifiedWidget> {
  UserBusinessBloc userBusinessBloc;

  PostCommentBloc postCommentBloc;
  Repository rep = Repository();

  // selected position of the busness creator
  int selectedPosition=0;
  String selectedPositionName='Manager/Ceo';
  String selectedUser='',selectedUserId='';
  User currentUser;

  List<String> roles=[
    'Owner/CEO',
    'Manager',
    'Employee',
    'Others'
  ];

  List<String> roleDefinition=[
    'Own the business',
    'Manage the business',
    'Works at the business',
    'Other position'
  ];

  @override
  void initState() {
    userBusinessBloc = BlocProvider.of<UserBusinessBloc>(context);
    postCommentBloc = BlocProvider.of<PostCommentBloc>(context);
    userBusinessBloc.add(FetchUserBusinessEvent(status: widget.status.toString()));

    rep.getCurrentUser().then((value) {
      setState(() {
        currentUser=value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: BlocListener<UserBusinessBloc, UserBusinessState>(
        listener: (content, state){
          if (state is UserBusinessLoadedState &&
              state.message != null) {
            // a message will only come when it is updating the feed.
          }
          else if (state is UserBusinessFailureState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Could not load Business  at this time"),));
          }
        },
        child: BlocBuilder<UserBusinessBloc, UserBusinessState>(
          builder: (context, state) {
            if (state is UserBusinessInitialState) {
              return buildLoading();
            } else if (state is UserBusinessLoadingState) {
              return buildLoading();
            } else if (state is UserBusinessLoadedState) {
              return buildUserBusiness(state.businessModel);
            }else if (state is UserBusinessEmptyState) {
              return buildErrorUi('You do not have any businesses yet');
            } else if (state is UserBusinessFailureState) {
              return buildErrorUi(state.error);
            }
            else {
              return buildErrorUi("Something went wrong!");
            }
          },
        ),
      ),

    );
  }

  Widget buildUserBusiness (BusinessModel userBusinessModel){
    return ListView.builder(
      itemCount: userBusinessModel.business.length,
      itemBuilder: (context, index){
         Business bizModel = userBusinessModel.business[index];
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all( 20),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
          color: Colors.grey[300], height: 60, width: 60,
               child: Image.network(Constant.IMAGE_BASE_URL+ userBusinessModel.business[index].photo, height: 60, width: 60,
                   errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                          return Container(color: Colors.grey[300], height: 60, width: 60);
                  }
                 ),
             ),
              SizedBox(height: 2),
              Text(userBusinessModel.business[index].name, style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 2),
              Text("Registered on " + Constants.formattedTime(userBusinessModel.business[index].createdOn), style: TextStyle(color: Colors.grey, fontSize: 12),),
              Text("Verified on "+Constants.formattedTime(userBusinessModel.business[index].updatedOn), style: TextStyle(color: Colors.red[900], fontSize: 12),),
              Row(
                children: [
                  Text("Last updated on " + Constants.formattedTime(userBusinessModel.business[index].updatedOn), style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                  SizedBox(width: 8),
                  Icon(Icons.edit, size: 13,),
                ],
              ),

              SizedBox(height: 20),

              GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (context) {
                      return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                            return FractionallySizedBox(
                              heightFactor: 0.35,
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(child: Text("Add an authorized Person?", style: TextStyle(fontSize: 18),)),
                                    Divider(),
                                    Text("An authorized person will be allowed to:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                    Text(" -Add/remove business offers in the app.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                    Text(" -Add/remove business photos on business profile.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                    Text(" -Business publicly in the name of the business.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

                                    Divider(color: Colors.grey),
                                    SizedBox(height: 10),

                                    Container (
                                      height: 40,
                                      margin:  EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 10.0 ),
                                      width: MediaQuery.of ( context ).size.width,
                                      child: (
                                          MaterialButton (
                                            elevation: 0,
                                            onPressed: (){
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                      builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                                        return FractionallySizedBox(
                                                          heightFactor: 0.80,
                                                          child: BlocProvider<InviteUserBloc>(
                                                              create: (context) => InviteUserBloc(inviteUserRepository: Repository()),
                                                              child:  BlocProvider<PostCommentBloc>(
                                                                  create: (context) => PostCommentBloc(postCommentRepository: Repository()),
                                                                  child: AuthorizeUserScreen(screen: "Add authorized user", id:userBusinessModel.business[index].id )
                                                              ),),);
                                                      });
                                                },
                                              );

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

                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  );
                },
                child: Row(
                  children: [
                    Text("Authorized people",style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.bold) ),
                    Spacer(),
                    Icon(Icons.add, size: 15,color: Colors.blueAccent,),
                    Text("Add", style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Divider(color: Colors.grey[700], height: 2),
              SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                itemCount:userBusinessModel.business[index].staff.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, pos){
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        margin: EdgeInsets.only(bottom: 10,top:10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: NetworkImage(Constant.IMAGE_BASE_URL+ userBusinessModel.business[index].staff[pos].profilePhoto),
                            )
                        ),
                      ),

                      SizedBox(width: 10),

                      Column(
                        // something = userBusinessModel.business.length,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(userBusinessModel.business[index].staff[pos].name, style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold),),

                              userBusinessModel.business[index].createdBy == userBusinessModel.business[index].staff[pos].id ?
                              Icon(Icons.stars, color: Colors.blueAccent, size: 15,)
                                  : Container(),
                            ],
                          ),
                          Text(roles[int.parse(userBusinessModel.business[index].staff[pos].role)], style: TextStyle(fontSize: 13)),
                          Text(roleDefinition[int.parse(userBusinessModel.business[index].staff[pos].role)], style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      Spacer(),

                      GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedUser =userBusinessModel.business[index].staff[pos].name;
                              selectedPosition=int.parse(userBusinessModel.business[index].staff[pos].role);
                              selectedUserId=userBusinessModel.business[index].staff[pos].id;
                            });
                           showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:35.0),
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          padding: EdgeInsets.all(20.0),
                                          alignment: Alignment.topCenter,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow (
                                                  color: Colors.black54.withOpacity (0.2 ),
                                                  blurRadius: 8.0,
                                                ),]
                                          ),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      backgroundColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
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
                                                                          Center(child: Text(selectedUser+"'s position at this business", style: TextStyle(fontSize: 17),)),
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
                                                                              postCommentBloc.add(AssignUserBusinessRoleEvent(userId: selectedUserId,busId:userBusinessModel.business[index].id , role:selectedPosition.toString(),action: 'update'));
                                                                              Navigator.of(context).pop();

                                                                              await Flushbar(
                                                                                message: selectedPositionName+" position now assigned to "+selectedUser,
                                                                                duration: Duration(seconds: 2),
                                                                              ).show(context).then((value) => (){
                                                                              });
                                                                              userBusinessBloc.add(FetchUserBusinessEvent(status: widget.status.toString()));

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
                                                    );
                                                  },
                                                  child: Text("Edit Position", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)
                                                  )
                                              ),
                                              InkWell(
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                                      ),
                                                      isScrollControlled: true,
                                                      backgroundColor: Colors.white,
                                                      builder: (context) {
                                                       return  currentUser==null? Container():    Padding(
                                                          padding: EdgeInsets.all(20),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                              // SizedBox(height: 15),
                                                              Text( currentUser.id!=selectedUserId? "Remove Authorization":"Resign Authorization",
                                                                style: TextStyle( fontSize: 18,
                                                                ),
                                                              ),
                                                              SizedBox(height: 10),

                                                              Divider(color: Colors.grey,),

                                                              SizedBox(height: 10),

                                                            currentUser.id!=selectedUserId?  Text( selectedUser +" will no longer be anauthorized person, this means no flash or fixed offer or coupons can be posted by this person on behalf of this business.",
                                                                style: TextStyle( fontWeight: FontWeight.w500, fontSize: 14, height: 1.5, wordSpacing: 1
                                                                ),
                                                              ):Text( "You will no longer be anauthorized person, this means no flash or fixed offer or coupons can be posted by this person on behalf of this business.",
                                                              style: TextStyle( fontWeight: FontWeight.w500, fontSize: 14, height: 1.5, wordSpacing: 1
                                                              ),
                                                            ),

                                                              SizedBox(height: 40),

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[

                                                                  Container(
                                                                    child: OutlineButton(
                                                                      borderSide: BorderSide(color: Colors.red.shade900,),
                                                                      child: Text(  currentUser.id!=selectedUserId? "Remove Anyway":"Resign Anyway",
                                                                        style: TextStyle(color: Colors.red.shade900, fontSize: 16,
                                                                        ),
                                                                      ),
                                                                      color: Colors.white,
                                                                      onPressed: () async{
                                                                        Navigator.pop(context);
                                                                        postCommentBloc.add(AssignUserBusinessRoleEvent(userId: selectedUserId,busId:userBusinessModel.business[index].id , role:selectedPosition.toString(),action: 'delete'));

                                                                        await Flushbar(
                                                                           message: 'done',
                                                                           duration: Duration(seconds: 2),
                                                                           ).show(context);
                                                                        userBusinessBloc.add(FetchUserBusinessEvent(status: widget.status.toString()));

                                                                      },
                                                                    ),
                                                                  ),

                                                                  SizedBox(width: 20),

                                                                  RaisedButton(
                                                                    child: Text( "  Cancel  ",
                                                                      style: TextStyle( color: Colors.white, fontSize: 16,
                                                                      ),
                                                                    ),
                                                                    // onPressed: ()=> Navigator.pop(context),
                                                                    onPressed: () async {
                                                                      Navigator.pop(context);


                                                                    },
                                                                    color: Colors.blueAccent,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top:15.0),
                                                    child: Text("Remove Authorization", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height:5),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          padding: EdgeInsets.all(20.0),
                                          alignment: Alignment.topCenter,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow (
                                                  color: Colors.black54.withOpacity (
                                                      0.2 ),
                                                  blurRadius: 8.0,
                                                ),]
                                          ),
                                          child: Column(
                                            children: [
                                              Text("Cancel", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:20),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(Icons.more_horiz))

                    ],
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }


  Widget buildLoading ( ) {
    return Center (
      child: CircularProgressIndicator ( ) ,
    );
  }

  Widget buildErrorUi ( String message ) {
    return Center (
      child: Text ( message , style: TextStyle ( color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18 ) ,
      ) ,
    );
  }
  
}
