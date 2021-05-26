import 'package:entertainmate/mate_home.dart';
import 'package:entertainmate/screens/congrats.dart';
import 'package:entertainmate/screens/profile.dart';
import 'package:flutter/material.dart';

class Mate extends StatefulWidget {
  @override
  _MateState createState() => _MateState();
}

class _MateState extends State<Mate> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Mate_Home(),
    Profile(),
    Congrats(),
    Profile(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EntertainMate", style: TextStyle(color: Colors.grey),),
        elevation: 0,
        backgroundColor: Colors.white,
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
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: _onItemTapped,


        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Deals',
            icon: Icon(Icons.backpack),
          ),
          BottomNavigationBarItem(
            label: 'Notification',
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
     body: _widgetOptions[_selectedIndex],


    );
  }
}
