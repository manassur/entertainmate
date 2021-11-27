import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ReportIncidentWidget extends StatefulWidget {
  @override
  _ReportIncidentWidgetState createState() => _ReportIncidentWidgetState();
}

class _ReportIncidentWidgetState extends State<ReportIncidentWidget> {
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
              title: Text("Report an Incident",
                  style: TextStyle( fontSize: 15, color: Colors.black38,  )),
            ),

            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container (
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                              Text("Inappropriate content",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("Short explanation",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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
                    SizedBox(height: 25),

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
                              Text("Fake Content",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("Short explanation",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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

                    SizedBox(height: 25),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedEventType=2;
                        });
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Racial/Sexual Content",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("Short explanation",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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
                                  backgroundColor: selectedEventType==2?Colors.blueAccent:Colors.white,
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
                          selectedEventType=3;
                        });
                      },
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Something else",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                              Text("Short explanation",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
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
                                  backgroundColor: selectedEventType==3?Colors.blueAccent:Colors.white,
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
                        await Flushbar(
                          message: 'Report Submitted',
                          duration: Duration(seconds: 3),
                        ).show(context);
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
