import 'package:flutter/material.dart';

class Mate extends StatefulWidget {
  @override
  _MateState createState() => _MateState();
}

class _MateState extends State<Mate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EntertainMate", style: TextStyle(color: Colors.grey),),elevation: 0,backgroundColor: Colors.white,
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
          )
        ],
      ) ,
      body: Container(
        color: Colors.white10,
        child: Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.timer,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.navigation,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Athens,OH',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),


                  ],
                ),
                Container(
                  child:  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.filter,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

        ),
      ),
    );
  }
}
