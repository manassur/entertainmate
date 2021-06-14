import 'dart:math';
import 'package:entertainmate/screens/complete_profile_screen.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:entertainmate/screens/utility/verify_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:entertainmate/mate.dart';
import 'package:entertainmate/screens/welcome.dart';


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
  VerifyUserProvider _detailsProvider;
  @override
  void initState() {
    super.initState ( );
    _detailsProvider = Provider.of<VerifyUserProvider>(context,listen:false);

  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOTP="";
  String errorMessage = '';
  TextEditingController _otpController = TextEditingController();
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
                            Navigator.push(context,    MaterialPageRoute(builder: (context) => CompleteProfileScreen(phone: widget.phoneNo,)));

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
                            Navigator.push(context,    MaterialPageRoute(builder: (context) => Welcome()));

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
                                builder: (BuildContext context) => CompleteProfileScreen(phone: widget.phoneNo,),
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

    _detailsProvider.setLoading(true);

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
        _detailsProvider.setLoading(true);
        _detailsProvider.setPhone(widget.phoneNo);
        _detailsProvider.checkIfUserIsFirstimeUser().then((value) => {
         print("at this point i have entered checkIfUserIsFirstimeUser()"+_detailsProvider.response.message),
       // if user is new
       if(_detailsProvider.response.message.toLowerCase().contains("new") == true){
         print("at this point i have entered checkIfUserIsFirstimeUser() 2"+_detailsProvider.response.message),

         //   if he has an invite, let him proceed
           if (_detailsProvider.response.isRefered == true ){
          _bottomSheetMore(context,_detailsProvider.response.referer)
        }else {
        // else ask him if he wants to proceed
        _bottomSheetYesOrNo(context,'')
      }
    }
       });

      }
      print("verId"+widget.verificationId);


      print("expected to have submitted");
    }catch(e){
      print("error dey o"+ e.toString());
      _detailsProvider.setMessage('could not  verify  at this time');
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
    return  Consumer<VerifyUserProvider>(
        builder: (context, data, child) {
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
                  child:  Text('Enter the 6 digit verification code we just texted you!',textAlign: TextAlign.center,),

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
                    style:TextStyle(fontSize:25),
                    keyboardType: TextInputType.number,
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
                            child:data.loading==false?
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
