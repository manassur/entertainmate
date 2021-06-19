import 'package:entertainmate/account_settings.dart';
import 'package:entertainmate/screens/edit_profile.dart';
import 'package:flutter/material.dart';


class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.grey[300],
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Photos",
              style: TextStyle( fontSize: 18, color: Colors.black87,  fontWeight: FontWeight.bold)),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text("Back", style: TextStyle(color: Colors.grey[900]),),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
              },
            )
          ],
        ),
        body:
        Padding(
          padding: const EdgeInsets.fromLTRB(7.0, 30.0, 7.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(7.0, 35.0, 7.0, 13.0),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton (
                    disabledColor: Colors.grey[200],
                    child: Text ( 'Skip',
                      style: TextStyle ( color: Colors.blue ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 6.0 ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 13.0),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton (
                    disabledColor: Colors.lightBlueAccent.withOpacity(0.2),
                    child: Text ( 'Done',
                      style: TextStyle ( color: Colors.grey ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 6.0 ),
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
