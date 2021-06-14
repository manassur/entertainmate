import 'dart:math';
import 'package:entertainmate/screens/complete_profile_screen.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:entertainmate/screens/utility/verify_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:entertainmate/mate.dart';
import 'package:entertainmate/screens/welcome.dart';

class Otp extends StatefulWidget {
  Otp({this.email,this.smsOTP});
String email;
String smsOTP='';
String verificationId;
  AuthCredential phoneAuthCredential;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  VerifyUserProvider _detailsProvider;
  String smsOTP='';
  String errorMessage = '';
  TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState ( );
    _detailsProvider = Provider.of<VerifyUserProvider>(context,listen:false);
  }

  void _bottomSheetMore(context, String referer) {
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
                  Visibility(
                      visible: referer.isNotEmpty==true,
                      child: Text('You have been invited by @'+referer+'!')),
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
                            Navigator.pop(context);
                            Navigator.push(context,    MaterialPageRoute(builder: (context) => CompleteProfileScreen(phone: widget.email,)));

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
  void _bottomSheetYesOrNo(context, String referer) {
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
                  Text('Do you wish to continue?',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text('oops! it seems you have not been invited to the EntertainMate app yet. However you can proceed to create your profile and we will notify you when any of your friends has invited you. \n Thanks for understanding '),
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
                            Navigator.pop(context);
                            Navigator.push(context,    MaterialPageRoute(builder: (context) =>Welcome()));

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
                              child: Center(child: Text('NO', style:TextStyle(fontSize: 15.0,color:Colors.red) ,)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkResponse(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>  CompleteProfileScreen(phone: widget.email,)
                              ),
                                  (route) => false,
                            );
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
                              child: Center(child: Text('YES', style:TextStyle(fontSize: 15.0,color:Colors.blue) ,)),
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
    _detailsProvider.setContext(context);
    _detailsProvider.setEmailLoading(true);

    /// get the `smsCode` from the user
    print("submittinh otp");
    if(smsOTP==widget.smsOTP){
      _detailsProvider.setEmailLoading(true);
      _detailsProvider.setEmail(widget.email);
      _detailsProvider.checkIfUserIsFirstimeUserWithEmail().then((value) => {
     if(_detailsProvider.response.message.toLowerCase().contains("new") == true){
         if (_detailsProvider.response.isRefered == true ){
        _bottomSheetMore(context,_detailsProvider.response.referer)
      }else {
      _bottomSheetYesOrNo(context,'')
    }
  }
     });

    }else{
      _detailsProvider.setMessage("The Otp you entered is in correct");
      print("Otp Wrong");
      _detailsProvider.setEmailLoading(false);
    }

  }



  @override
  Widget build(BuildContext context) {
    return  Consumer<VerifyUserProvider>(
        builder: (context, data, child) {
          data.setLoading(false);
          return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Log in', style: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold,
        color: Colors.black,
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
                  child:  Text('Enter the 6 digit verification code that was sent to your email!',textAlign: TextAlign.center,),

                ),
              ),
            ),
            SizedBox(
                height: 8
            ),

            Container(
              margin:EdgeInsets.only(left:20,right:20),
              padding:EdgeInsets.symmetric(horizontal:20,vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width:1,
                  color: Colors.grey[300],
                ),),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    style:TextStyle(fontSize:25),
                    textAlign: TextAlign.center,
                    controller: _otpController,
                    onChanged:(value) {
                      setState(() {
                        smsOTP = value;
                      });
                    },
                    decoration:InputDecoration(
                        counterText: "",

                        border:InputBorder.none,
                        hintText: 'Verification Code'
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
                        child: Center(
                            child:data.isEmailLoading()==false?
                            Text('Next', style:TextStyle(fontSize: 17.0,color:smsOTP.isNotEmpty? Colors.white:Colors.black) ,)
                                : SizedBox(height: 20,width: 20, child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),))
                        ),
                    ),
                  ),
                ),)
              ],
            ),
          ],
        ),
      ),
        );
        }
        );
  }
}
