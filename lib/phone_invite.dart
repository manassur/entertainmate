import 'package:flutter/material.dart';

class Phone_Invite extends StatefulWidget {
  @override
  _Phone_InviteState createState() => _Phone_InviteState();
}

class _Phone_InviteState extends State<Phone_Invite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white10,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10,25,10,0),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'Search in your phone contacts list',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  suffixIcon: Icon(Icons.cancel_outlined, color: Colors.grey,),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0),),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),)
      ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,30.0,10.0,0),
                  child: CircleAvatar(
                   backgroundColor: Colors.black,
                    radius: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Text('BB', style: TextStyle(color: Colors.black),),
                    ) ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,30,30,0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bahareh Baheri',style: TextStyle(
                            fontWeight: FontWeight.w700),),
                        Text('blablabla',style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.grey),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,10.0,10.0,0),
                  child: RaisedButton(
                    child: Text('Invite',style: TextStyle(color: Colors.black),),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
