import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../invite.dart';
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,

            body: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Column(
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

                      Container(
                          height: 600,
                          child: TabBarView(children: <Widget>[
                            //BIOGRAPHY TAB
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                color: Colors.grey[100],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        width: 70,
                                        height: 70,
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(data.user.firstname,
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0,
                                        ),),
                                    ),
                                    Text(data.user.headline,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),),
                                    Text("@" + data.user.username,
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17.0,
                                      )),

                                    SizedBox(height: 30),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text("1", style: TextStyle(
                                                fontWeight: FontWeight.w600),),
                                            Text('Followers',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text('1', style: TextStyle(
                                                fontWeight: FontWeight.w600),),
                                            Text('Following',
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .w600),),
                                          ],
                                        ),
                                        MaterialButton(
                                          elevation: 0,
                                          onPressed: () {
                                            if (data.user.invites < 5) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Invite()));
                                            } else {
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
                                          color: data.user.invites < 5
                                              ? Colors.lightBlueAccent.withOpacity(0.1)
                                              : Colors.blue,
                                          disabledColor: Colors.grey[400],
                                          child: Text(
                                            '    Invite Friends    ',
                                            style: TextStyle(
                                                color: Colors.grey[800]),),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Divider(color: Colors.black87,),
                                    Container(
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 30.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                  'images/005-instagram.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user
                                                      .instagram
                                                      .isNotEmpty ? Colors
                                                      .black87 : Colors
                                                      .grey,),
                                                SvgPicture.asset(
                                                  'images/004-twitter.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user.twitter
                                                      .isNotEmpty ? Colors
                                                      .black87 : Colors
                                                      .grey,),
                                                SvgPicture.asset(
                                                  'images/003-facebook.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user
                                                      .facebook.isNotEmpty
                                                      ? Colors.black87
                                                      : Colors.grey,),
                                                SvgPicture.asset(
                                                  'images/002-linkedin-logo.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user
                                                      .linkedin.isNotEmpty
                                                      ? Colors.black87
                                                      : Colors.grey,),
                                                SvgPicture.asset(
                                                  'images/001-email.svg',
                                                  height: 25,
                                                  width: 20,
                                                  color: data.user.email
                                                      .isNotEmpty ? Colors
                                                      .black87 : Colors
                                                      .grey,),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 40),

                                          Center(
                                              child: Text("MORE ABOUT ME", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),)),

                                          SizedBox(height: 15),

                                          Container(
                                            padding: EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10.0)
                                            ),
                                            child: Text(" Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.Lorem ipsum dolor sitamet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.Lorem ipsum dolor sitamet, consectetur adipiscing elit, sed do eiusmod tempor.",
                                              // child: Text(data.user.bio,

                                                style: TextStyle(fontWeight: FontWeight.w500, height: 1.5, wordSpacing: 1),),)
                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                              ),
                            ),


                            //MEDIA TAB
                            SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text("Media Screen"),

                                  ],
                                ),
                              ),
                            ),

                            //EXPENSES TAB
                            SingleChildScrollView(
                              child: Container(
                                child: Text("Expenses Screen"),
                              ),
                            ),

                          ]))
                    ])
            ),

          );
        });
  }
}

