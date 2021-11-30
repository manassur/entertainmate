import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class BusinessPositionWidget extends StatefulWidget {
  @override
  _BusinessPositionWidgetState createState() => _BusinessPositionWidgetState();
}

class _BusinessPositionWidgetState extends State<BusinessPositionWidget> {
  int selectedPosition=0;

  @override
  Widget build(BuildContext context) {
           return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container (
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Center(child: Text("Your position at this business", style: TextStyle(fontSize: 20),)),
                    Divider(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedPosition=0;
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
                        Navigator.pop(context);
                        await Flushbar(
                          message: 'Position saved',
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
            );
          // );
  }
}
