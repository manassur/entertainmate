import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile", style: TextStyle(color: Colors.grey),),elevation: 0,backgroundColor: Colors.white,),
      body: Container(
        child: Column(
          children: [
            //circula
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: new DecorationImage(
                    image: AssetImage('images/sara.jpg'),
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text('Sara Ghanadian', style: TextStyle(
                fontFamily: 'SF Pro',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ) ,),
            ),
            Text('Data scientist at Inspired Brands', style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,10.0,10.0,0),
                  child: Column(
                    children: [
                      Text('1',style: TextStyle(
                          fontWeight: FontWeight.w700),),
                      Text('Followers', style: TextStyle(
                          fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,10.0,10.0,0),
                  child: Column(
                    children: [
                      Text('1',style: TextStyle(
                          fontWeight: FontWeight.w700),),
                      Text('Following',style: TextStyle(
                          fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,10.0,10.0,0),
                  child: RaisedButton(
                    child: Text('Invite Friends',style: TextStyle(color: Colors.white),),
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        ),
                  ),
                ),
              ],
            ),
              Divider(),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
              height: 250,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('@Saragh,'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Industrial and Systems Engineering, PhD \nData scientist & ML engineer\nDance | Music | Party\nAtlanta, GA '),
                    Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('images/005-instagram.svg', height: 20, width: 15, color: Colors.grey,),
                          SvgPicture.asset('images/004-twitter.svg', height: 20, width: 15, color: Colors.grey,),
                          SvgPicture.asset('images/003-facebook.svg', height: 20, width: 15, color: Colors.grey,),
                          SvgPicture.asset('images/002-linkedin-logo.svg', height: 20, width: 15, color: Colors.grey,),
                          SvgPicture.asset('images/001-email.svg', height: 20, width: 15, color: Colors.grey,),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Spacer(),
            Container(
              margin: EdgeInsets.all(10),
              height: 40.0,
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.grey )),
                onPressed: () {},
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                textColor: Colors.black,
                child: Text("Edit Profile",
                    style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40.0,
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                onPressed: () {},
                padding: EdgeInsets.all(10.0),
                color: Color.fromRGBO(0, 160, 227, 1),
                textColor: Colors.white,
                child: Text("Save and Continue",
                    style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
