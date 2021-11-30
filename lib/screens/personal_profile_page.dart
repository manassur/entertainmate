import 'package:entertainmate/screens/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../invite.dart';
import 'events_item.dart';
import 'utility/complete_profile_provider.dart';
import 'utility/constants.dart' as Constants;

class PersonalProfileScreen extends StatefulWidget {

  @override
  _PersonalProfileScreenState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,

            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: SizedBox(
                              height: 50,
                              child: AppBar(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                bottom: TabBar(
                                  unselectedLabelColor: Colors.grey[700],
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelColor: Colors.blue,
                                  labelPadding: EdgeInsets.all(0),
                                  tabs: [
                                    Tab(
                                      text: "Biography",
                                    ),
                                    Tab(
                                      text: "Activities",
                                    ),
                                    Tab(
                                      text: "Messages",
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),

                          SingleChildScrollView(
                            child: Container(
                                height: 700,
                                //height of TabBarView SOEMTHING HAS TO BE DONE
                                //ABOUT THIS STATIC HEIGHT FOR THE TABBAR

                                child: TabBarView(children: <Widget>[
                                  //BIOGRAPHY TAB
                                  Container(
                                    color: Colors.grey[100],
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Center(
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20),
                                                      image: new DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                          Constants.IMAGE_BASE_URL+ data.user.profilePhoto),
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(data.user.firstname,
                                              style: TextStyle(
                                                fontFamily: 'SF Pro',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25.0,
                                              ),),
                                          ),
                                        ),
                                        Center(
                                          child: Text(data.user.headline,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),),
                                        ),

                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 0),
                                              child: Column(
                                                children: [
                                                  Text('1', style: TextStyle(
                                                      fontWeight: FontWeight.w700),),
                                                  Text('Followers',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700),),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(
                                                  30.0, 10.0, 10.0, 0),
                                              child: Column(
                                                children: [
                                                  Text('1', style: TextStyle(
                                                      fontWeight: FontWeight.w700),),
                                                  Text('Following',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w700),),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(
                                                  10.0, 10.0, 20.0, 0),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  if (data.user.invites < 5) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                Invite()));
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: 'You have used up your invites',
                                                        toastLength: Toast
                                                            .LENGTH_SHORT,
                                                        gravity: ToastGravity
                                                            .TOP,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors
                                                            .black,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0
                                                    );
                                                  }
                                                },
                                                color: data.user.invites < 5
                                                    ? Colors.black87
                                                    : Colors.black12,
                                                disabledColor: Colors.grey[400],
                                                child: Text(
                                                  '    Invite Friends    ',
                                                  style: TextStyle(
                                                      color: Colors.white),),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(10.0),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                        Divider(),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 20, 10, 15),
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text("@" + data.user.username,
                                                  style: TextStyle(
                                                    fontFamily: 'SF Pro',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.0,
                                                  ),),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(data.user.bio,
                                                  style: TextStyle(
                                                    fontFamily: 'SF Pro',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.0,
                                                  ),),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(top: 30.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'images/005-instagram.svg',
                                                        height: 20,
                                                        width: 15,
                                                        color: data.user
                                                            .instagram
                                                            .isNotEmpty ? Colors
                                                            .black87 : Colors
                                                            .grey,),
                                                      SvgPicture.asset(
                                                        'images/004-twitter.svg',
                                                        height: 20,
                                                        width: 15,
                                                        color: data.user.twitter
                                                            .isNotEmpty ? Colors
                                                            .black87 : Colors
                                                            .grey,),
                                                      SvgPicture.asset(
                                                        'images/003-facebook.svg',
                                                        height: 20,
                                                        width: 15,
                                                        color: data.user
                                                            .facebook.isNotEmpty
                                                            ? Colors.black87
                                                            : Colors.grey,),
                                                      SvgPicture.asset(
                                                        'images/002-linkedin-logo.svg',
                                                        height: 20,
                                                        width: 15,
                                                        color: data.user
                                                            .linkedin.isNotEmpty
                                                            ? Colors.black87
                                                            : Colors.grey,),
                                                      SvgPicture.asset(
                                                        'images/001-email.svg',
                                                        height: 20,
                                                        width: 15,
                                                        color: data.user.email
                                                            .isNotEmpty ? Colors
                                                            .black87 : Colors
                                                            .grey,),


                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),



                                      ],
                                    ),

                                  ),


                                  //MEDIA TAB
                                  Container(
                                    child: Text("Media Screen"),
                                  ),

                                  //EXPENSES TAB
                                  Container(
                                    child: Text("Expenses Screen"),
                                  ),


                                ])),
                          )
                        ])
                ),


              ],
            ),

          );
        });

  }
}

