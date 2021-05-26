import 'package:flutter/material.dart';

class Account_Settings extends StatefulWidget {
  @override
  _Account_SettingsState createState() => _Account_SettingsState();
}

class _Account_SettingsState extends State<Account_Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,40,0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      Text('Back', style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
                Center(
                  child: Text('Account Settings', style: TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Text('Log Out', style: TextStyle(color: Colors.blueAccent, fontSize: 15),),
                ),
              ],
            ),
          ),
      body: Container(
        color: Colors.white12,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top:35.0),
                child: Container(
                  margin: EdgeInsets.all(30.0),
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.topCenter,
                  width: 100,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Events", style: TextStyle(fontSize: 15)),
                          Spacer(),
                          Icon(Icons.event_note_outlined),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Local deals", style: TextStyle(fontSize: 15)),
                          Spacer(),
                          Icon(Icons.money_outlined),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.all(30.0),
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Updates", style: TextStyle(fontSize: 15)),
                    Divider(),
                    Text("FAQ", style: TextStyle(fontSize: 15)),
                    Divider(),
                    Text("Terms of use", style: TextStyle(fontSize: 15)),
                    Divider(),
                    Text("Privacy policies", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        );
  }
}
