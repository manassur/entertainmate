import 'package:entertainmate/account_settings.dart';
import 'package:entertainmate/invite.dart';
import 'package:entertainmate/screens/edit_profile.dart';
import 'package:entertainmate/screens/events_item.dart';
import 'package:entertainmate/screens/personal_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'email_invite.dart';
import 'profile_profile_business.dart';

class ProfileMain extends StatefulWidget {
  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
          return  DefaultTabController(
            length: 2,
      child: Scaffold (
        backgroundColor: Colors.grey[200],
        appBar: AppBar (
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
              },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,    MaterialPageRoute(builder: (context) => Account_Settings()));
              },
            ),
            // Row(
            //   children: [
            //     IconButton(
            //       icon: Icon(
            //         Icons.create,
            //         color: Colors.black,
            //       ),
            //       onPressed: () {
            //    Navigator.push(context,    MaterialPageRoute(builder: (context) => EditProfile()));
            //       },
            //     ),
            //     IconButton(
            //       icon: Icon(
            //         Icons.settings,
            //         color: Colors.black,
            //       ),
            //       onPressed: () {
            //         Navigator.push(context,    MaterialPageRoute(builder: (context) => Account_Settings()));
            //       },
            //     ),
            //   ],
            // )
          ],
          centerTitle: true,
          elevation: 0,
          title:  Container(
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
                      child: Text("Personal"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Business"),
                    ),
                  ),
                ]),
          ),


        ),
        body:Container(
          child: TabBarView(children: [
            PersonalProfileScreen(),
            BusinessProfileScreen()

          ]),
        ),
      ),
    );
  });
  }
}
