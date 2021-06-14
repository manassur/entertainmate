import 'package:flutter/material.dart';

class MateNotification extends StatefulWidget {
  @override
  _MateNotificationState createState() => _MateNotificationState();
}

class _MateNotificationState extends State<MateNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  RichText(
          text: TextSpan(
              text: 'Entertain',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20,fontWeight: FontWeight.w700),
              children: <TextSpan>[
                TextSpan(text: 'Mate',
                  style: TextStyle(
                      color: Colors.blueAccent, fontSize: 20,fontWeight: FontWeight.w700),

                )
              ]
          ),),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[

        ],
      ) ,

    );
  }
}
