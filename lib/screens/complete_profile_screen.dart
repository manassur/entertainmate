import 'package:entertainmate/screens/swipe_widget.dart';
import 'package:entertainmate/screens/complete_name.dart';
import 'package:entertainmate/screens/complete_bio.dart';
import 'package:entertainmate/screens/complete_social.dart';

import 'package:entertainmate/screens/complete_add_photo.dart';
import 'package:entertainmate/screens/welcome.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'complete_done.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'utility/verify_user_provider.dart';


class CompleteProfileScreen extends StatefulWidget {
  String phone;
  CompleteProfileScreen({this.phone});
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  PageController controller = PageController();

  int currentPage=0;
  CompleteProfileProvider _detailsProvider;

  @override
  void initState() {
    super.initState ( );
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);
    _detailsProvider.setPhone(widget.phone);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkResponse(
            onTap: (){
              //Provider. of<CompleteProfileProvider>(context,listen: false). dispose();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>   MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (_) => CompleteProfileProvider()),
                        ChangeNotifierProvider(create: (_) => VerifyUserProvider()),
                      ],child: Welcome())
                ),
                    (route) => false,
              );
            },
            child: Center(child: Text("Cancel",style: TextStyle(color: Colors.black87),))),
        title: Center(child: Text("Complete your profile",style: TextStyle(color: Colors.black87),)),
        actions: [Center(child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Visibility(
            visible: _detailsProvider.currentPage!=0 && _detailsProvider.currentPage!=4,
              child: InkResponse(onTap: (){
                if((_detailsProvider.currentPage!=0 && _detailsProvider.currentPage!=4)){
                var  pagetogo = _detailsProvider.currentPage+1;
                  _detailsProvider.setCurrentPage(pagetogo);
                }
                } ,
                  child: Text("skip",style: TextStyle(color:Colors.blue),))),
        ))],
      ),
        body: Container(
          padding: EdgeInsets.all(10),

          child: Column(
            children: [
              SmoothPageIndicator(
                  controller: _detailsProvider.controller,  // PageController
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
                  controller: _detailsProvider.controller,
                    physics : NeverScrollableScrollPhysics(),
                  onPageChanged: (int pageno){
                    setState(() {
                      currentPage = pageno;
                      _detailsProvider.setCurrentPage(pageno);
                    });
                  },
                  children: [
                    CompleteName(phone: widget.phone,),
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
