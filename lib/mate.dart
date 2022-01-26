import 'package:entertainmate/mate_home.dart';
import 'package:entertainmate/screens/mate_notification.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '/screens/utility/constants.dart' as Constants;

import 'bloc/feed_home/mate_home_bloc.dart';
import 'mate_deals.dart';
import 'screens/profile_main.dart';
import 'screens/utility/complete_profile_provider.dart';

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
        create: (context) => MateHomeBloc(mateHomeRepository: Repository(),context:context),
        child: MateHome()
    ),
    BlocProvider<MateHomeBloc>(
        create: (context) => MateHomeBloc(mateHomeRepository: Repository()),
        child: MateDeals()
    ),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: RichText(
                text: TextSpan(
                    text: _selectedIndex ==0?'Events':'Offers',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                    ]
                ),),
              elevation: 0,
              backgroundColor: Colors.white,
              actions: <Widget>[

                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                      ),
                      onPressed: () {


                      },
                    ),
                    IconButton(

                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {

                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => ProfileMain()));
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(Constants.IMAGE_BASE_URL+ data.profilePhoto),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
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
        });
  }
}
