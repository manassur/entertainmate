import 'package:flutter/material.dart';

class Congrats extends StatefulWidget {
  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
              image: AssetImage('images/street.jpg'),
              fit: BoxFit.cover
          ) ,
        )
        ),
      );
  }
}
