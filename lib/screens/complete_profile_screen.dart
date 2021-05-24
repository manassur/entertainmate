import 'package:entertainmate/screens/swipe_widget.dart';
import 'package:entertainmate/screens/complete_name.dart';
import 'package:entertainmate/screens/complete_bio.dart';
import 'package:entertainmate/screens/complete_social.dart';

import 'package:entertainmate/screens/complete_add_photo.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'complete_done.dart';


class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  PageController controller = PageController();

  int currentPage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Center(child: Text("Cancel",style: TextStyle(color: Colors.black87),)),
        title: Center(child: Text("Complete your profile",style: TextStyle(color: Colors.black87),)),
        actions: [Center(child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("skip",style: TextStyle(color:Colors.blue),),
        ))],
      ),
        body: Container(
          padding: EdgeInsets.all(10),

          child: Column(
            children: [
              SmoothPageIndicator(
                  controller: controller,  // PageController
                  count:  5,
                  effect:  SlideEffect(
                    dotColor:   Colors.grey[200],
                    activeDotColor: Colors.blue.withOpacity(0.7),
                    radius:  10.0,
                    dotWidth:  50.0,
                    dotHeight:  5.0,
                  ),  // your preferred effect
                  onDotClicked: (index){

                  }
              ),
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (int pageno){
                    setState(() {
                      currentPage = pageno;
                    });
                  },
                  children: [
                    CompleteName(),
                    CompleteBio(),
                    CompleteAddPhoto(),
                    CompleteSocial(),
                    CompleteDone(),
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }
}
