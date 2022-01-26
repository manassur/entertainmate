import 'package:country_code_picker/country_code_picker.dart';
// import 'file:///C:/Users/Olugunde/Documents/FlutterApps/entertainmate/lib/screens/verify_email/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  String phoneNo = "";
  String smsOTP;
  String errorMessage = '';
  TextEditingController _phoneNumberController = TextEditingController();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child)
    {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 15),
              width: double.maxFinite,
              child: Card(
                color: Colors.blue[50],
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome,'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('This is EntertainMate and we hope you get the \nbest out of this app. EntertainMate is in the Beta-\ntesting and it is accessible only by invitation. We\nare working hard to make it widely accessible in\nthe near future. '),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Cheers,'),
                      Text('EntertainMate Team.')
                    ],
                  ),
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
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:InputDecoration(
                            counterText: "",
                            border:InputBorder.none,
                            hintText: 'Enter your email'
                        ),
                        onChanged:(value) {
                          setState(() {
                            phoneNo =  value;
                          });
                        },
                    controller: _phoneNumberController,

                  ))
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: InkResponse(
                    onTap: (){
                      if(_phoneNumberController.text.isNotEmpty){

                        data.sendEmailOtp(_phoneNumberController.text,context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color:phoneNo.isEmpty? Colors.white.withOpacity(0.9):Colors.blue,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 8.0,
                              )
                            ]
                        ),
                        child: Center(
                            child:data.isEmailOtpLoading()==false?
                            Text('Next', style:TextStyle(fontSize: 17.0,color:phoneNo.isNotEmpty? Colors.white:Colors.black) ,)
                                : SizedBox(height: 20,width: 20, child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),))
                        ),
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
    });

  }
}
