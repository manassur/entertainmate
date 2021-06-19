import 'package:entertainmate/screens/description_screen.dart';
import 'package:entertainmate/screens/location_screen.dart';
import 'package:entertainmate/screens/new_in_person_event.dart';
import 'package:entertainmate/screens/photo_screen.dart';
import 'package:entertainmate/screens/target_audience.dart';
import 'package:entertainmate/screens/title_screen.dart';
import 'package:flutter/material.dart';


class InPersonEventScreen extends StatefulWidget {
  @override
  _InPersonEventScreenState createState() => _InPersonEventScreenState();
}

class _InPersonEventScreenState extends State<InPersonEventScreen> {
  bool _flutter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      resizeToAvoidBottomInset: false,
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
      body: Padding(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Text("Pickeball indoor", style: TextStyle(color: Colors.grey[800], fontSize: 17.8),),
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.lock_outline, color: Colors.grey[700],),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Public", style: TextStyle(fontSize: 16, color: Colors.grey[800]),),
                                Text("Visible to anyone on Entertainmate", style: TextStyle(fontSize: 15, color: Colors.grey),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.person_pin, color: Colors.grey[700],),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Open to OU students only",
                                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),),
                                Text("Looking for 2 people", style: TextStyle(fontSize: 15, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, color: Colors.grey[700],),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0,),
                            child: Row(
                              children: [
                                Text("Tomorrow ", style: TextStyle(fontSize: 16, color: Colors.grey[800]),),
                                Text(". ", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                Text("June 5, 2020 ", style: TextStyle(fontSize: 16, color: Colors.grey[800]),),
                                Text(". ", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                Text("05.00pm", style: TextStyle(fontSize: 16, color: Colors.red),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, color: Colors.grey[700],),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Text("Tomorrow ", style: TextStyle(fontSize: 16, color: Colors.grey[800]),),
                                Text(". ", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                Text("June 5, 2020 ", style: TextStyle(fontSize: 16, color: Colors.grey[800]),),
                                Text(". ", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                Text("07.00pm", style: TextStyle(fontSize: 16, color: Colors.red),),
                              ],
                            ),                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.grey[700],),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Athens Rec Center",
                                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),),
                                Text("25 East St, Athens, OH", style: TextStyle(fontSize: 15, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.create, color: Colors.grey,),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0,right: 15.0),
                              child: Container(
                                width: 300,
                                child: Text("We are a group of 5 to 10 people that every Friday get together and play pickleball at the OU tennis center or Athens rec center. Feel free to join us and enjoy this amazing sport.",
                                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                          ),
                        ],
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

              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton (
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewInPersonEventScreen()));
                    },
                    disabledColor: Colors.blue,
                    color: Colors.blue,
                    child: Text ( 'Publish',
                      style: TextStyle ( color: Colors.white ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 7.0 ),
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
