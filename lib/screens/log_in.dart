import 'file:///C:/Users/Olugunde/Documents/FlutterApps/entertainmate/lib/screens/verify_phone/phone_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'verify_email/email_widget.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation:0,
            title: Text('Log in', style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: new PreferredSize(
            preferredSize: new Size(0.0, 40.0),
              child: Container(
                decoration:BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: TabBar(
                  
                    unselectedLabelColor: Colors.black87,
                    labelColor: Colors.black87,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.white, Colors.white]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Phone Number"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Email address"),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          body: TabBarView(children: [
            Phone(),
           Email(),
          ]),
        )
    );
  }
}
