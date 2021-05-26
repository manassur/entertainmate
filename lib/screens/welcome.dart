import 'package:entertainmate/screens/swipe_widget.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cancel.dart';
import 'log_in.dart';
import 'package:firebase_core/firebase_core.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController controller = PageController();

  int currentPage=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: currentPage == 0?BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                image: AssetImage('images/street.jpg'),
                fit: BoxFit.cover
            ) ,
          ):BoxDecoration(  color: Colors.white70,
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (int pageno){
                    setState(() {
                      currentPage = pageno;
                    });
                  },
                  children: [
                    SwipeWidget(title: "EntertainMate",description: "swipe left to view exciting features you get to enjoy" ,isFirstPage: true,),
                    SwipeWidget(title: "Welcome to EntertainMate",description: "Inviting friends to have fun together just got easier, faster and at your fingertips" ,),
                    SwipeWidget(title: "Lonely & Bored",description: "Schedule events and see who else is interested in coming along" ,),
                    SwipeWidget(title: "Filter Participants",description: "Decide who attends your created event from interested people" ,),
                    SwipeWidget(title: "Best deals from local stores",description: "Be the first to get informed on best deals from local stores near you" ,),
                    SwipeWidget(title: "Business Owner?",description: "The huge social community provides a platform to advertise your services" ,),


                  ],
                ),
              ),
              SmoothPageIndicator(
                  controller: controller,  // PageController
                  count:  6,
                  effect:  ExpandingDotsEffect(
                    dotColor: currentPage == 0?Colors.white70:  Colors.grey,
                    activeDotColor:currentPage == 0?Colors.white:  Colors.blue.withOpacity(0.7),
                    radius:  10.0,
                    dotWidth:  12.0,
                    dotHeight:  10.0,
                  ),  // your preferred effect
                  onDotClicked: (index){

                  }
              ),
              SizedBox(height: 30),
              InkResponse(
                onTap: (){
                  Navigator.push(context,    MaterialPageRoute(builder: (context) => Login()));

                },
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text('Continue to login', style:TextStyle(fontSize: 13.0) ,),
                ),),
              SizedBox(
                height: 20,
              ),
              Text('By continuing you agree to our Terms of use and Privacy Policies',
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontSize: 13.0, fontWeight: FontWeight.normal,
                  color: currentPage==0? Colors.white:Colors.black87,
                ),),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
    );
  }
}
