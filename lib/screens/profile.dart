import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'complete_profile_screen.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
    return Scaffold (
      backgroundColor: Colors.grey[200],
      appBar: AppBar (
        leading: IconButton(color:Colors.grey,icon:Icon( Icons.arrow_back_ios),onPressed: (){Navigator.of(context).pop();},),
        title: Text ( "Profile", style: TextStyle ( color: Colors.grey ), ),
        elevation: 0,
        backgroundColor: Colors.white, ),
      body: Container (
        child: Stack(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),bottomRight: Radius.circular(80)),
                color: Colors.white

              ),
            ),
            Column (
              children: [
                //circula
                data.image==null?
                Padding (
                  padding: const EdgeInsets.only( top: 8.0 ),
                  child: Container (
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration (
                        shape: BoxShape.circle,
                        color: Colors.white,

                    ),
                  ),
                ):
                Padding (
                  padding: const EdgeInsets.only( top: 8.0 ),
                  child: Container (
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration (
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(data.image),
                        )
                    ),
                  ),
                ),
                Padding (
                  padding: const EdgeInsets.only( top: 8.0 ),
                  child: Text ( data.name, style: TextStyle (
                    fontFamily: 'SF Pro',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25.0,
                  ), ),
                ),
                Text ( data.headline, style: TextStyle (
                  color: Colors.black,
                  fontSize: 20.0,
                ), ),

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
                  padding: EdgeInsets.fromLTRB ( 10, 0, 10, 15 ),
                  height: 250,
                  width: double.maxFinite,
                  child: Padding (
                    padding: const EdgeInsets.fromLTRB( 20.0, 0.0, 20.0, 20.0 ),
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text ( "@"+data.username,style: TextStyle (
                          fontFamily: 'SF Pro',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),  ),
                        SizedBox (
                          height: 10,
                        ),
                        Text ( data.bio,style:TextStyle (
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
                                color:data.instagram.isNotEmpty?Colors.black87: Colors.grey, ),
                              SvgPicture.asset (
                                'images/004-twitter.svg', height: 20,
                                width: 15,
                                color:data.twitter.isNotEmpty?Colors.black87: Colors.grey, ),
                              SvgPicture.asset (
                                'images/003-facebook.svg', height: 20,
                                width: 15,
                                color:data.facebook.isNotEmpty?Colors.black87: Colors.grey, ),
                              SvgPicture.asset (
                                'images/002-linkedin-logo.svg', height: 20,
                                width: 15,
                                color:data.linkedin.isNotEmpty?Colors.black87: Colors.grey, ),
                              SvgPicture.asset ( 'images/001-email.svg', height: 20,
                                width: 15,
                                color:data.email.isNotEmpty?Colors.black87: Colors.grey, ),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider ( ),
                Spacer ( ),
                Container (
                  margin: EdgeInsets.all ( 10 ),
                  height: 40.0,
                  width: double.infinity,
                  child: RaisedButton (
                    shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 10.0 ),
                        side: BorderSide ( color: Colors.grey ) ),
                    onPressed: (
                        ) {

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CompleteProfileScreen(phone: data.phone,),
                        ),
                            (route) => false,
                      );
                      data.setCurrentPage(0);
                    },
                    padding: EdgeInsets.all ( 10.0 ),
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text ( "Edit Profile",
                        style: TextStyle ( fontSize: 15 ) ),
                  ),
                ),
                Container (
                  margin: EdgeInsets.all ( 10 ),
                  height: 40.0,
                  width: double.infinity,
                  child: RaisedButton (
                    shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 10.0 ),
                        side: BorderSide (
                            color: Color.fromRGBO ( 0, 160, 227, 1 ) ) ),
                    onPressed: (
                        ) {
                      data.setContext(context);
                      data.saveCompleteData();
                    },
                    padding: EdgeInsets.all ( 10.0 ),
                    color: Color.fromRGBO ( 0, 160, 227, 1 ),
                    textColor: Colors.white,
                    child:data.saveCompleteLoading==true?
                    SizedBox(
                      height: 20,
                        width: 20,
                        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)): Text ( "Save and Continue",
                        style: TextStyle ( fontSize: 15 ) ),
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  });
  }
}
