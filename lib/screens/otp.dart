import 'dart:math';
import 'package:entertainmate/screens/complete_profile_screen.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Otp extends StatefulWidget {
  Otp({this.phoneNo,this.verificationId,this.smsOTP,this.phoneAuthCredential});
String phoneNo;
String smsOTP;
String verificationId;
  AuthCredential phoneAuthCredential;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOTP="";
  String errorMessage = '';
  TextEditingController _otpController = TextEditingController();
  void _bottomSheetMore(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return  Container(
            height: 300,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),


            child:  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to EntertainMate!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                  SizedBox(
                    height: 10,
                  ),
                  Text('You have been invited by @user!'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('One more step is to finalize your registration. Please continue and complete your profile. We hope you enjoy this app.'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Cheers,'),
                  Text('EntertainMate Team.'),

                  Row(
                    children: [
                      Expanded(
                        child: InkResponse(
                          onTap: (){
                            Navigator.push(context,    MaterialPageRoute(builder: (context) => CompleteProfileScreen()));

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color:Colors.white.withOpacity(0.9),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.2),
                                      blurRadius: 8.0,
                                    )
                                  ]
                              ),
                              child: Center(child: Text('GOT IT', style:TextStyle(fontSize: 15.0,color:Colors.blue) ,)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            )
          );
        },
    );
  }


  void _submitOTP() async{
    /// get the `smsCode` from the user
    print("submittinh otp");
    String smsCode = _otpController.text.toString().trim();
    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    try{
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId:widget.verificationId,
        smsCode: smsCode,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      final User currentUser =  _auth.currentUser;
      if(user.uid == currentUser.uid){
        _bottomSheetMore(context);

      }
      print("verId"+widget.verificationId);


      print("expected to have submitted");
    }catch(e){
      print("error dey o"+ e.toString());

      handleError(e);
    }

  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
    print("error : " + errorMessage);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        title: Center(
        child: Text('Log in', style: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold,
        color: Colors.black,
           ),
        ),
          ),
        ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(

              padding: EdgeInsets.fromLTRB(10, 20, 10, 15),
              height: 120,
              width: double.maxFinite,
              child: Card(
                color: Colors.blue[50],
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:  Text('Enter the 6 digit verification code we just texted you!',textAlign: TextAlign.center,),

                ),
              ),
            ),
            SizedBox(
                height: 8
            ),

            Container(
              margin:EdgeInsets.only(left:30,right:30),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    controller: _otpController,
                    onChanged:(value) {
                      setState(() {
                        smsOTP = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Verification Code',
                    ),

                  ))
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: InkResponse(
                    onTap: (){
                      if(_otpController.text.isNotEmpty){
                        _submitOTP();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color:smsOTP.isEmpty? Colors.white.withOpacity(0.9):Colors.blue,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 8.0,
                              )
                            ]
                        ),
                        child: Center(child: Text('Next', style:TextStyle(fontSize: 15.0,color:smsOTP.isNotEmpty? Colors.white:Colors.black) ,)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
