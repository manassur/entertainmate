import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),),
      body: Container(
        child: Column(
          children: [
            //circula
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Container(
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text('Sara Ghanadian', style: TextStyle(
                fontFamily: 'SF Pro',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ) ,),
            ),
            Text('Data scientist at Inspired Brands', style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,10.0,10.0,0),
                  child: Column(
                    children: [
                      Text('1'),
                      Text('Followers'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,10.0,10.0,0),
                  child: Column(
                    children: [
                      Text('1'),
                      Text('Following'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,10.0,10.0,0),
                  child: RaisedButton(
                    child: Text('Invite Friends'),
                    textColor: Colors.white,
                    color: Colors.grey,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
              Divider(),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 15),
              height: 250,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('@Saragh,'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Industrial and Systems Engineering, PhD \nData scientist & ML engineer\nDance | Music | Party\nAtlanta, GA '),
                    Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('images/download.png'),
                          Icon(Icons.keyboard_backspace),
                          Icon(Icons.keyboard_backspace),
                          Icon(Icons.keyboard_backspace),
                          Icon(Icons.keyboard_backspace),
                          Icon(Icons.keyboard_backspace),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0,0.0,20.0,0.0),
              child: RaisedButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Center(child: Text("Edit Profile")),
                ),
                color: Colors.white,
                textColor: Colors.black,
                splashColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0,5.0,20.0,0.0),
              child: RaisedButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Center(child: Text("Save & Continue")),
                ),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ],
        ),

      ),
    );
  }
}
