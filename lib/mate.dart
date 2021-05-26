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
      body: Column(
        children: [
          Container(
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

                  ],
                ),
            ),
          ),
          Spacer(),
      BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            onTap: (value) {
              // Respond to item press.
            },
            items: [
              BottomNavigationBarItem(
                title: Text('Home', style: TextStyle(color: Colors.black),),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text('Deals', style: TextStyle(color: Colors.black),),
                icon: Icon(Icons.backpack),
              ),
              BottomNavigationBarItem(
                title: Text('Notification', style: TextStyle(color: Colors.black),),
                icon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                title: Text('Profile', style: TextStyle(color: Colors.black),),
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
