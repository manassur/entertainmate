
import 'package:entertainmate/screens/in_person_event.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  @override
  Widget build(BuildContext context) {
          return Scaffold (
            backgroundColor: Colors.grey[300],
            appBar:  AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text("Create new event",
                  style: TextStyle( fontSize: 18, color: Colors.black87,  fontWeight: FontWeight.bold)),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Cancel", style: TextStyle(color: Colors.grey[900]),),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container (
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InPersonEventScreen()));

                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all( Radius.circular(15), ),),
                               elevation: 4,
                          child: Container(
                      child: Stack(
                         alignment: Alignment.bottomCenter,
                           children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(15),
                            child: Container(
                             color: Colors.white,
                              height: 200,
                ),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10)),
                  child: Container(
                      color: Colors.grey[100],
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,5,0,5),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline_outlined, color: Colors.black87,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("In-person",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                            ),
                          ],
                        ),
                      ),
                  )
              ),

            ],
          ),
    )

                      ),
                    ),

                    SizedBox(height: 15),

                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all( Radius.circular(15), ),),
                        elevation: 4,
                        child: Container(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  color: Colors.white,
                                  height: 200,
                                ),
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10)),
                                  child: Container(
                                    color: Colors.grey[100],
                                    height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20.0,5,0,5),
                                      child: Row(
                                        children: [
                                          Icon(Icons.ac_unit_sharp, color: Colors.black87,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("Online",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),

                            ],
                          ),
                        )

                    ),


                  ],
                ),

              ),
            ),
          );
  }
}
