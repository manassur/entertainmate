import 'package:flutter/material.dart';

class Complete5 extends StatefulWidget {
  @override
  _Complete5State createState() => _Complete5State();
}

class _Complete5State extends State<Complete5> {
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
                child: Text('Name', style:TextStyle(fontSize: 10.0) ,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_open_rounded,
                    ),
                  Container(
                    width: 2,
                    height: 500,
                    color: Colors.black,
                  ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text('Headline', style:TextStyle(fontSize: 10.0) ,),
                    ),
                  ],
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
                child: Text('@username', style:TextStyle(fontSize: 10.0) ,),
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
                  color: Colors.blueGrey.withOpacity(0.9),
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
