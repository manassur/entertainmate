import 'package:entertainmate/mate_home.dart';
import 'package:entertainmate/screens/mate_deals.dart';
import 'package:entertainmate/screens/mate_notification.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/feed_home/mate_home_bloc.dart';
import 'screens/profile_main.dart';

class Mate extends StatefulWidget {
  @override
  _MateState createState() => _MateState();
}

class _MateState extends State<Mate> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[

    BlocProvider<MateHomeBloc>(
        create: (context) => MateHomeBloc(mateHomeRepository: Repository()),
        child: MateHome()
    ),
    MateDeals(),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.store_mall_directory_rounded),
          ),

        ],
      ),
     body: _widgetOptions[_selectedIndex],


    );
  }
}
