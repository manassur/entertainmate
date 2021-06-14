import 'dart:async';

import 'package:entertainmate/screens/congrats.dart';
import 'package:entertainmate/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../mate.dart';
import 'model/user.dart';
import 'repository/repository.dart';
import 'utility/complete_profile_provider.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 Repository _userRepository;
  bool isUserLoggedIn = false;
  User user = User();
 CompleteProfileProvider _detailsProvider;

  @override
  void initState() {
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);

    _userRepository = Repository();

    _userRepository.isLoggedIn().then((value) => {
      setState(() {
        isUserLoggedIn = value;
      }),
      if(value==true){
        _userRepository.getCurrentUser().then((valuee) =>   {
          setState(() {
            _userRepository.checkIfUserIsFirstTimeUserId(valuee.username).then((valueee) =>   {
              user = valuee,
              if(valueee.isRefered==true){
                print("confirm user is verified"+user.isVerified.toString()),
                user.isVerified=valueee.isRefered,
                user.invites = valueee.user.invites,
                user.isNameChanged = valueee.user.isNameChanged,

                _detailsProvider.setUser(user),
                _userRepository.loginUser(_detailsProvider.user),
                startTime()

              }else{
                print("yo no even try"),
                print("user after all parsing ; "+ jsonEncode(user)),
                if(valueee.message.contains("new")){
                  _userRepository.logoutUser()

                }else{
                  user.isVerified=false,
                  user.referer = '',
                  _detailsProvider.setUser(user),
                  _userRepository.logoutUser()
                },
                startTime()

              },});
          }),
        },)
      }else{
        print("not logged in"),
        startTime()
      }
    });
    super.initState();
  }

  startTime() async {
    var duration = new Duration(seconds: 1);
    return new Timer(duration, route);
  }

  route() {
    if (!isUserLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  Welcome(),
          ),

      );
    } else {
      print("why ish dey"+_detailsProvider.user.isVerified.toString());
      if(_detailsProvider.user.isVerified==true){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Mate(),
          ),
              (route) => false,
        );

      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Welcome()),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child:    RichText(
            text: TextSpan(
                text: 'Entertain',
                style: TextStyle(
                    color: Colors.black, fontSize: 30,fontWeight: FontWeight.w700),
                children: <TextSpan>[
                  TextSpan(text: 'Mate',
                    style: TextStyle(
                        color: Colors.blueAccent, fontSize: 30,fontWeight: FontWeight.w700),
                  )
                ]
            ),),
        ),
      ),
    );
  }
}
