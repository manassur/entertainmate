import 'package:entertainmate/screens/phone_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            title: Center(
              child: Text('Log in', style: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
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
            Icon(Icons.movie),
          ]),
        )
    );
  }
}
