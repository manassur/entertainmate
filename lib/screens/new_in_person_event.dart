import 'package:entertainmate/screens/description_screen.dart';
import 'package:entertainmate/screens/happening_now.dart';
import 'package:entertainmate/screens/location_screen.dart';
import 'package:entertainmate/screens/photo_screen.dart';
import 'package:entertainmate/screens/target_audience.dart';
import 'package:entertainmate/screens/title_screen.dart';
import 'package:flutter/material.dart';


class NewInPersonEventScreen extends StatefulWidget {
  @override
  _NewInPersonEventScreenState createState() => _NewInPersonEventScreenState();
}

class _NewInPersonEventScreenState extends State<NewInPersonEventScreen> {
  bool _flutter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.grey[300],
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("New in-person event",
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
      body:
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TitleScreen()));
                        },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text("Title", style: TextStyle(color: Colors.grey, fontSize: 17.8),),
                          )),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.lock_outline, color: Colors.grey,),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                            child: Text("Privacy", style: TextStyle(fontSize: 16, color: Colors.grey),),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TargetAudienceScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.person_pin, color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                              child: Text("Target audience", style: TextStyle(fontSize: 16, color: Colors.grey),),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, color: Colors.grey,),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Text("Start ", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                Text("date ", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                Text("and time", style: TextStyle(fontSize: 16, color: Colors.grey),),

                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, color: Colors.grey,),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                            child: Text("End date and time", style: TextStyle(fontSize: 16, color: Colors.grey),),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                              child: Text("Location", style: TextStyle(fontSize: 16, color: Colors.grey),),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey,),
                      InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.create, color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                              child: Text("Description", style: TextStyle(fontSize: 16, color: Colors.grey),),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoScreen()));

                        },
                        child: Row(
                          children: [
                            Icon(Icons.add_a_photo_rounded, color: Colors.grey,),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                              child: Text("Photos", style: TextStyle(fontSize: 16, color: Colors.grey),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SwitchListTile(
                title: Text('Show location to the audience',
                  style: TextStyle(fontSize: 16),),
                value: _flutter,
                activeColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) {
                  setState(() {
                    _flutter = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('First interested first added to DM ROOM',
                  style: TextStyle(fontSize: 16),
                ),
                value: _flutter,
                activeColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) {
                  setState(() {
                    _flutter = value;
                  });
                },
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration (
                    shape: BoxShape.circle,
                    color: Colors.black87,
                  ),
                  child:Center(child: Text("UI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17), )),

                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton (
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HappeningNowScreen()));
                    },
                    color: Colors.lightBlueAccent.shade100.withOpacity(0.9),
                    // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                    child: Text ( 'Publish',
                      style: TextStyle ( color: Colors.grey ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 10.0 ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }
}
