import 'package:flutter/material.dart';

class Enter extends StatefulWidget {
  @override
  _EnterState createState() => _EnterState();
}

class _EnterState extends State<Enter> {
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
                  child: Text('Log in',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
                child: Center(child: Text('Enter the 4-digit verification code\n           we just texted you!', style:TextStyle(fontSize: 15.0) ,)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 10),
              child: Container(
                height: 40,
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
                child: Center(child: Text('Verification Code', style:TextStyle(fontSize: 10.0) ,)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Verification Code Enter the 4-digit verification code', style:TextStyle(fontSize: 8)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
              child: Container(
                height: 30,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blueGrey.withOpacity(0.9),
                ),
                child: Center(child: Text('Send', style:TextStyle(fontSize: 10.0) ,)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
