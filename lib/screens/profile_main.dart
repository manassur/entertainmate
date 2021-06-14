import 'package:entertainmate/account_settings.dart';
import 'package:entertainmate/invite.dart';
import 'package:entertainmate/screens/edit_profile.dart';
import 'package:entertainmate/screens/events_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileMain extends StatefulWidget {
  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
    return Scaffold (
      backgroundColor: Colors.grey[200],
      appBar: AppBar (
        title: Text ( "Profile", style: TextStyle ( color: Colors.grey ), ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.create,
                  color: Colors.black,
                ),
                onPressed: () {
             Navigator.push(context,    MaterialPageRoute(builder: (context) => EditProfile()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context,    MaterialPageRoute(builder: (context) => Account_Settings()));
                },
              ),
            ],
          )
        ],
      ),
      body: Container (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100)),
                      color: Colors.white

                  ),
                ),
                Padding (
                  padding: const EdgeInsets.only( top: 8.0 ),
                  child: Center(
                    child: Container (
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration (
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage ( data.user.profilePhoto ),
                          )
                      ),
                    ),
                  ),
                ),


              ],
            ),
            Center(
              child: Padding (
                padding: const EdgeInsets.only( top: 8.0 ),
                child: Text ( data.user.firstname, style: TextStyle (
                  fontFamily: 'SF Pro',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0,
                ), ),
              ),
            ),
            Center(
              child: Text ( data.user.headline, style: TextStyle (
                color: Colors.black,
                fontSize: 20.0,
              ), ),
            ),

            Row (
              children: [
                Padding (
                  padding: const EdgeInsets.fromLTRB( 30.0, 10.0, 10.0, 0 ),
                  child: Column (
                    children: [
                      Text ( '1', style: TextStyle (
                          fontWeight: FontWeight.w700 ), ),
                      Text ( 'Followers', style: TextStyle (
                          fontWeight: FontWeight.w700 ), ),
                    ],
                  ),
                ),
                Padding (
                  padding: const EdgeInsets.fromLTRB( 30.0, 10.0, 10.0, 0 ),
                  child: Column (
                    children: [
                      Text ( '1', style: TextStyle (
                          fontWeight: FontWeight.w700 ), ),
                      Text ( 'Following', style: TextStyle (
                          fontWeight: FontWeight.w700 ), ),
                    ],
                  ),
                ),
                Spacer ( ),
                Padding (
                  padding: const EdgeInsets.fromLTRB( 10.0, 10.0, 20.0, 0 ),
                  child: RaisedButton (
                    onPressed: (){
                      if(data.user.invites<5){
                      Navigator.push(context,    MaterialPageRoute(builder: (context) => Invite()));
                      }else{
                        Fluttertoast.showToast(
                            msg: 'You have used up your invites',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                    },
                    color:data.user.invites<5? Colors.black87:Colors.black12,
                    disabledColor: Colors.grey[400],
                    child: Text ( '    Invite Friends    ',
                      style: TextStyle ( color: Colors.white ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 10.0 ),
                    ),
                  ),
                ),

              ],
            ),
            Divider ( ),
            Container (
              padding: EdgeInsets.fromLTRB ( 10, 20, 10, 15 ),
              width: double.maxFinite,
              child: Padding (
                padding: const EdgeInsets.fromLTRB( 20.0, 0.0, 20.0, 10.0 ),
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text ( "@"+data.user.username,style: TextStyle (
                      fontFamily: 'SF Pro',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),  ),
                    SizedBox (
                      height: 10,
                    ),
                    Text ( data.user.bio,style:TextStyle (
                      fontFamily: 'SF Pro',
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                    ), ),
                    Padding (
                      padding: const EdgeInsets.only( top: 30.0 ),
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset (
                            'images/005-instagram.svg', height: 20,
                            width: 15,
                            color:data.user.instagram.isNotEmpty?Colors.black87: Colors.grey, ),
                          SvgPicture.asset (
                            'images/004-twitter.svg', height: 20,
                            width: 15,
                            color:data.user.twitter.isNotEmpty?Colors.black87: Colors.grey, ),
                          SvgPicture.asset (
                            'images/003-facebook.svg', height: 20,
                            width: 15,
                            color:data.user.facebook.isNotEmpty?Colors.black87: Colors.grey, ),
                          SvgPicture.asset (
                            'images/002-linkedin-logo.svg', height: 20,
                            width: 15,
                            color:data.user.linkedin.isNotEmpty?Colors.black87: Colors.grey, ),
                          SvgPicture.asset ( 'images/001-email.svg', height: 20,
                            width: 15,
                            color:data.user.email.isNotEmpty?Colors.black87: Colors.grey, ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider ( ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all ( 10 ),
                  child: Text ( "Events Organized",
                    style: TextStyle (
                      fontFamily: 'SF Pro',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ), ),),
              ],
            ),
            Spacer ( ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EventsItem(eventName: "Social",),
                      EventsItem(eventName: "Sports",),

                    ],
                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: [
//                      EventsItem(eventName: "Arts",),
//                      EventsItem(eventName: "Nature",),
//
//                    ],
//                  ),
                ],
              ),
            )


          ],
        ),

      ),
    );
  });
  }
}
