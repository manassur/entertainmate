import 'package:entertainmate/bloc/feed_home/mate_home_bloc.dart';
import 'package:entertainmate/bloc/feed_home/mate_home_state.dart';
import 'package:entertainmate/bloc/old_event/old_event_bloc.dart';
import 'package:entertainmate/bloc/old_event/old_event_event.dart';
import 'package:entertainmate/bloc/old_event/old_event_state.dart';
import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/model/old_event_model.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RenewOldEventScreen extends StatefulWidget {

   RenewOldEventScreen({Key key}) : super(key: key);

  @override
  _RenewOldEventScreenState createState() => _RenewOldEventScreenState();
}

class _RenewOldEventScreenState extends State<RenewOldEventScreen> {
  TextEditingController searchController= TextEditingController();
  OldEventBloc oldEventBloc;

  @override
  void initState() {
    oldEventBloc = BlocProvider.of<OldEventBloc>(context);
    oldEventBloc.add(FetchOldEventEvent());    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Container(),
        title: Text("Renew an old event", style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 16),),
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.wifi), color: Colors.black87,)
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Divider(),
                Container (
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration (
                      borderRadius: BorderRadius.circular ( 10.0 ),
                      color: Colors.grey[100],
                    ),
                    width: MediaQuery.of ( context ).size.width,
                    child: TextField (
                      controller: searchController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration (
                          counterText: "",
                          border: InputBorder.none,
                          prefixIcon: Icon ( Icons.search ),
                          suffixIcon: Icon(Icons.add_circle,color: Colors.grey.shade400,),
                          hintText: 'Search here',
                          hintStyle: TextStyle (color: Colors.grey, fontSize: 15 )
                      ),
                      onChanged: ( value ) {
                        // data.setDescription(value);
                      },
                    )
                ),

              ],
            ),
          ),

          //event list
          BlocListener <OldEventBloc, OldEventState>(
            listener: (context, state){
              if ( state is OldEventRefreshingState ) {
                Scaffold.of ( context ).showSnackBar ( SnackBar (
                  content: Text ( 'Refreshing' ) , ) );
              } else if ( state is OldEventLoadedState && state.message != null ) {

              }
              else if ( state is OldEventFailureState ) {
                Scaffold.of ( context ).showSnackBar ( SnackBar (
                  content: Text ( "Could not load Feeds at this time" ),
                ) );
              }
            },

            child: BlocBuilder<OldEventBloc, OldEventState>(
              builder: (context, state) {
                if ( state is OldEventInitialState ) {
                  return buildLoading ( );
                } else if ( state is OldEventLoadingState ) {
                  return buildLoading ( );
                } else if ( state is OldEventLoadedState ) {
                  return buildOldEventList ( state.oldEvent);
                } else if ( state is OldEventFailureState ) {
                  return buildErrorUi ( state.error );
                }
                else {
                  return buildErrorUi ( "Something went wrong!" );
                }
              },
            ),

          ),

          Container (
            height: 40,
            margin:  EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 10.0 ),
            width: MediaQuery.of ( context ).size.width,
            child: (
                MaterialButton (
                  elevation: 0,
                  onPressed: () {},
                  color: Colors.lightBlue.shade100,
                  // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                  child: Text ( 'Next',
                    style: TextStyle ( color: Colors.grey ), ),
                  shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular ( 5.0 ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOldEventList (OldEventModel oldEventModel){
    return Expanded(
      child: ListView.builder(
        itemCount: oldEventModel.feeds.length,
        itemBuilder: (context,pos){
          return  Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB( 20.0, 15.0, 20.0, 0.0),
                padding: EdgeInsets.fromLTRB( 20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey.shade600, width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                            '${oldEventModel.feeds[pos].username}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),

                    SizedBox(height: 5),

                    Text(
                      "${oldEventModel.feeds[pos].post.content}",
                      style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),),

                    SizedBox(height: 5),

                    Text("June 4 2021 ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                    Text("9:00 PM - 12:00 AM", style: TextStyle(fontSize: 13, color: Colors.deepOrange.withOpacity(0.5)),),
                    Text(
                        "2 Andover Rd, Athens, OH 45701",
                        style: TextStyle( fontSize: 13,  decoration: TextDecoration.underline,
                        )),

                    SizedBox(height: 15),

                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 3.0, 15.0, 3.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(13.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 13.0,
                            backgroundImage: AssetImage("images/entertainmate_pic.jpeg",),
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name name name",  style: TextStyle( fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
                              Text("June 1, 2021",  style: TextStyle( fontSize: 10, color: Colors.grey.shade500)),

                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                      child: Divider(color: Colors.grey),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Reactions ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                            Text("${oldEventModel.feeds[pos].post.saves}",
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                          ],
                        ),
                        Spacer(),

                        Row(
                          children: [
                            Text(
                                "${oldEventModel.feeds[pos].post.comments}",
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                            Text(" Comments", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                          ],
                        ),

                        SizedBox(width: 12.0,),

                        Row(
                          children: [
                            Text(
                                "${oldEventModel.feeds[pos].post.interests}",
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                            Text(" Shares", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Positioned(
                right: 17.0,
                top: 28.0,
                child: RotationTransition(
                  turns:  AlwaysStoppedAnimation(20 / 200),
                  child:  Container(
                      padding: EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Text("Passed", style: TextStyle(color: Colors.white, fontSize: 12),)),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildLoading ( ) {
    return Container(
      margin: EdgeInsets.only(top:50),
      child: Center (
        child: CircularProgressIndicator ( ) ,
      ),
    );
  }

  Widget buildErrorUi ( String message ) {
    return Center (
      child: Text ( message , style: TextStyle ( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20 ) ,
      ) ,
    );
  }
}

