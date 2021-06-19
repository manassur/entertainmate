import 'package:flutter/material.dart';


class DescriptionScreen extends StatefulWidget {
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.grey[300],
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Description",
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
        ),
        body:
        Padding(
          padding: const EdgeInsets.fromLTRB(7.0, 30.0, 7.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:InputDecoration(
                            counterText: "",
                            border:InputBorder.none,
                            prefixIcon: Icon(Icons.create),
                            hintText: 'More details about your event',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                        ),
                        onChanged:(value) {
                          setState(() {
                          });
                        },

                      ),
                    )
                ),
              ),

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
