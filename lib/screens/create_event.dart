
import 'package:entertainmate/bloc/publish_event/publish_event_bloc.dart';
import 'package:entertainmate/screens/new_in_person_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/repository.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

  int selectedEventType=0;
  int selectedEventClass=0;
  @override
  Widget build(BuildContext context) {
          return Scaffold (
            backgroundColor: Colors.white,
            appBar:  AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              centerTitle: true,
              title: Text("Create new event",
                  style: TextStyle( fontSize: 15, color: Colors.black38,  )),

            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container (
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Event type?",
                        style: TextStyle( fontSize: 17, color: Colors.blueAccent,fontWeight: FontWeight.w500  )),
                    SizedBox(height: 15),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedEventType=0;
                        });
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("In-person",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("Social / Sports / Arts / Nature",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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
                                  backgroundColor:   selectedEventType==0?Colors.blueAccent:Colors.white,
                                  radius: 10,

                                )
                            ),

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedEventType=1;
                        });
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Online",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("Gaming / Open discussion / Arts / Nature",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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
                                  backgroundColor: selectedEventType==1?Colors.blueAccent:Colors.white,
                                  radius: 10,

                                )
                            ),

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 15),

                    Text("Event class?",
                        style: TextStyle( fontSize: 17, color: Colors.blueAccent,fontWeight: FontWeight.w500  )),
                    SizedBox(height: 15),


                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedEventClass=0;
                        });
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Non-nonymous",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("People's name and photo are visible",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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
                                  backgroundColor: selectedEventClass==0?Colors.blueAccent:Colors.white,
                                  radius: 10,

                                )
                            ),

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedEventClass=1;
                        });
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Anonymous",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("People's name and photo are hidden",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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
                                  backgroundColor: selectedEventClass==1?Colors.blueAccent:Colors.white,
                                  radius: 10,

                                )
                            ),

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),


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
                                heightFactor: 0.8,
                                child: BlocProvider<PublishEventBloc>(
                                  create: (context) =>
                                      PublishEventBloc(repository: Repository(),context:context),
                                  child: NewInPersonEventScreen(type:selectedEventType,clas:selectedEventClass),
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
                    SizedBox(height: 15),



                  ],
                ),

              ),
            ),
          );
  }
}
