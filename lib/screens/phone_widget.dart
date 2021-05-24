import 'package:country_code_picker/country_code_picker.dart';
import 'package:entertainmate/screens/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  String phoneNo = "";
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  AuthCredential _phoneAuthCredential;
  CountryCode cc;

  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    setState(() {
      cc=countryCode;

    });
  }

  Future<void> _submitPhoneNumber() async {
    /// NOTE: Either append your phone number country code or add in the code itself
    String phoneNumber = cc.dialCode + _phoneNumberController.text.toString().trim();
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print(error);
    }

    void codeSent(String verificationId, [int code]) {
      setState(() {
        smsOTP = code.toString();
      });
      Navigator.push(context,    MaterialPageRoute(builder: (context) => Otp(phoneNo: this._phoneNumberController.text,verificationId: verificationId,smsOTP: this.smsOTP,phoneAuthCredential: this._phoneAuthCredential,)));
      print('codeSent' + code.toString());
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
      timeout: Duration(milliseconds: 10000),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(

            padding: EdgeInsets.fromLTRB(10, 20, 10, 15),
            height: 250,
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
           margin:EdgeInsets.only(left:30,right:30),
           child: Text('Login with phone number is currently available in USA only ',
            style: TextStyle(
              fontSize: 13.0, fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),),
          SizedBox(
              height: 8
          ),
          Container(
            margin:EdgeInsets.only(left:30,right:30),
            child: Row(
              children: [
                CountryCodePicker(
                  onChanged: _onCountryChange,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'NG',
                  favorite: ['+39','FR'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
                Expanded(
                    child: TextField(
                      onChanged:(value) {
                        setState(() {
                          phoneNo = value;
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
                      _submitPhoneNumber();
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
                      child: Center(child: Text('Next', style:TextStyle(fontSize: 15.0,color:phoneNo.isNotEmpty? Colors.white:Colors.black) ,)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
