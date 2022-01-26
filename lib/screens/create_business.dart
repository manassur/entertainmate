import 'package:another_flushbar/flushbar.dart';
import 'package:entertainmate/bloc/publish_event/publish_event_bloc.dart';
import 'package:entertainmate/bloc/user_business/user_business_bloc.dart';
import 'package:entertainmate/bloc/user_business/user_business_event.dart';
import 'package:entertainmate/bloc/user_business/user_business_state.dart';
import 'package:entertainmate/screens/new_in_person_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constant;
import 'model/businessModel.dart';
import 'repository/repository.dart';
import 'utility/constants.dart';

class CreateBusiness extends StatefulWidget {
  @override
  _CreateBusinessState createState() => _CreateBusinessState();
}

class _CreateBusinessState extends State<CreateBusiness> {

  int selectedIndex=0;
  UserBusinessBloc userBusinessBloc;

  @override
  void initState() {
    userBusinessBloc = BlocProvider.of<UserBusinessBloc>(context);
    userBusinessBloc.add(FetchUserBusinessEvent());
    super.initState();
  }



  Widget buildUserBusiness (BusinessModel userBusinessModel){
    return Column(
      children: [
        Container(
          height: 250,
          child: ListView.builder(
            itemCount: userBusinessModel.business.length,
            itemBuilder: (context, index){
              Business bizModel = userBusinessModel.business[index];
              return GestureDetector(
                onTap: (){
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      color: Colors.white,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 25,
                            backgroundImage: NetworkImage(Constant.IMAGE_BASE_URL+ userBusinessModel.business[index].photo),),

                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(userBusinessModel.business[index].name, style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),),
                              Text( userBusinessModel.business[index].location, style: TextStyle(color: Colors.grey, fontSize: 15),),
                              Divider(color: Colors.grey[700], height: 2),

                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 14,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 13,
                                child: CircleAvatar(
                                  backgroundColor:   selectedIndex==index?Colors.blueAccent:Colors.white,
                                  radius: 10,

                                )
                            ),

                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {

                return FractionallySizedBox(
                  heightFactor: 0.6,
                  child: BlocProvider<PublishEventBloc>(
                    create: (context) =>
                        PublishEventBloc(repository: Repository(),context:context),
                    child: NewInPersonEventScreen(type:0,clas:0,branch:1,busid:int.parse(userBusinessModel.business[selectedIndex].id)),
                  ),);
              },
            );

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
        SizedBox(height: 5),
      ],
    );
  }


  Widget buildLoading ( ) {
    return Center (
      child: CircularProgressIndicator ( ) ,
    );
  }

  Widget buildErrorUi ( String message ) {
    return Center (
      child: Text ( message , style: TextStyle ( color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );
  }
  @override
  Widget build(BuildContext context) {
          return Scaffold (
            backgroundColor: Colors.white,
            appBar:  AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              centerTitle: true,
              title: Text("Select the business!",
                  style: TextStyle( fontSize: 15, color: Colors.black87,  )),

            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: BlocListener<UserBusinessBloc, UserBusinessState>(
                  listener: (content, state){
                    if (state is UserBusinessLoadedState &&
                        state.message != null) {
                      if(state.businessModel.business.isEmpty){
                        Flushbar(
                          message: "You have no business yet",
                          icon: Icon(
                            Icons.done,
                            size: 28.0,
                            color: Colors.white,
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.blueAccent,
                        )..show(context);
                      }
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
                      } else if (state is UserBusinessEmptyState) {
                        return buildErrorUi('You do not have any business created yet');
                      }else if (state is UserBusinessFailureState) {
                        return buildErrorUi(state.error);
                      }
                      else {
                        return buildErrorUi("Something went wrong!");
                      }
                    },
                  ),
                ),

              ),
            ),
          );
  }
}
