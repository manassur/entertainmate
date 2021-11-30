import 'package:entertainmate/bloc/user_business/user_business_bloc.dart';
import 'package:entertainmate/bloc/user_business/user_business_event.dart';
import 'package:entertainmate/bloc/user_business/user_business_state.dart';
import 'package:entertainmate/screens/model/businessModel.dart';
import 'package:entertainmate/screens/utility/constants.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'package:entertainmate/widgets/business_position_widget.dart';
import 'package:entertainmate/widgets/business_type_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessVerifiedWidget extends StatefulWidget {

  Business business;


  @override
  _BusinessVerifiedWidgetState createState() => _BusinessVerifiedWidgetState();
}

class _BusinessVerifiedWidgetState extends State<BusinessVerifiedWidget> {
  UserBusinessBloc userBusinessBloc;

  @override
  void initState() {
    userBusinessBloc = BlocProvider.of<UserBusinessBloc>(context);
    userBusinessBloc.add(FetchUserBusinessEvent());
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
              // Image.asset("images/entertainmate_pic.jpeg", height: 60, width: 60,),
             Image.network(Constant.IMAGE_BASE_URL+ userBusinessModel.business[index].photo),

              SizedBox(height: 10),
              Text(userBusinessModel.business[index].name, style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),),
              Text("Registered on " + Constants.formattedTime(userBusinessModel.business[index].createdOn), style: TextStyle(color: Colors.grey, fontSize: 15),),
              Text("Verified on June 5, 2021", style: TextStyle(color: Colors.red[900], fontSize: 14),),
              Row(
                children: [
                  Text("Last updated on " + Constants.formattedTime(userBusinessModel.business[index].updatedOn), style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                  Icon(Icons.edit, size: 20,),
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
                                            onPressed: () {Navigator.pop(context);},

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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              // image:AssetImage("images/entertainmate_pic.jpeg"),fit: BoxFit.cover,
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
                              Text("Muhmamedzilla Agbshdf", style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),),
                              Icon(Icons.stars, color: Colors.blueAccent, size: 15,),
                            ],
                          ),
                          Text("Manager"),
                          Text("Registered the business", style: TextStyle(color: Colors.grey, fontSize: 15)),
                        ],
                      ),
                      Spacer(),

                      GestureDetector(
                          onTap: (){
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
                                                                  heightFactor: 0.60,
                                                                  child: BusinessPositionWidget());
                                                            });
                                                      },
                                                    );
                                                  },
                                                  child: Text("Edit Position", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)
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
      child: Text ( message , style: TextStyle ( color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );
  }
  
}
