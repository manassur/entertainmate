import 'package:flutter/material.dart';

class MateDeals extends StatefulWidget {
  @override
  _MateDealsState createState() => _MateDealsState();
}

class _MateDealsState extends State<MateDeals> {
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
