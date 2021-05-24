import 'package:flutter/material.dart';

class Complete3 extends StatefulWidget {
  @override
  _Complete3State createState() => _Complete3State();
}

class _Complete3State extends State<Complete3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
                  child: Text('Cancel', style: TextStyle(fontSize: 15),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 0, 10),
                  child: Text('Complete your profile',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blueGrey.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(child: Text('Please enter your name,headline,and\n           username to continue!', style:TextStyle(fontSize: 15.0) ,)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Container(
                height: 400,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white.withOpacity(0.9),
                  border: Border.all(
                    width:1,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Container(
                height: 30,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue.withOpacity(0.9),
                ),
                child: Center(child: Text('Next', style:TextStyle(fontSize: 10.0) ,)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
