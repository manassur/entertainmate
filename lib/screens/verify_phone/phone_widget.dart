import 'package:country_code_picker/country_code_picker.dart';
import 'package:entertainmate/screens/utility/verify_user_provider.dart';
import 'package:entertainmate/screens/verify_phone/otp.dart';
import '../complete_profile_screen.dart';
// import 'file:///C:/Users/Olugunde/Documents/FlutterApps/entertainmate/lib/screens/verify_phone/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:entertainmate/screens/welcome.dart';
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
  CountryCode cc= CountryCode();
  bool isLoading=false;
  VerifyUserProvider _detailsProvider;

  @override
  void initState() {
    super.initState ( );
     cc= CountryCode.fromCode("NG");
    _detailsProvider = Provider.of<VerifyUserProvider>(context,listen:false);

  }
  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    setState(() {
      cc=countryCode;

    });
  }

  void _submitOTP(AuthCredential phoneAuthCredential,String phone) async{
    _detailsProvider.setContext(context);

    _detailsProvider.setLoading(true);

    /// get the `smsCode` from the user
    print("submittinh otp");
    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    try{

      final User user = (await _auth.signInWithCredential(phoneAuthCredential)).user;
      final User currentUser =  _auth.currentUser;
      if(user.uid == currentUser.uid){
        _detailsProvider.setLoading(true);
        _detailsProvider.setPhone(phone);
       await _detailsProvider.checkIfUserIsFirstimeUser().then((value) => {
       // if user is new
       if(_detailsProvider.response.message.toLowerCase().contains("new") == true){
           //   if he has an invite, let him proceed
           if (_detailsProvider.response.isRefered == true ){
          _bottomSheetMore(context,_detailsProvider.response.referer)
        }else {
        // else ask him if he wants to proceed
        _bottomSheetYesOrNo(context,'')
      }
    }
       });

        print("isNewUser? :" +_detailsProvider.response.message);
        print ('isRefered? :'+ _detailsProvider.response.isRefered.toString());


      }


      print("expected to have submitted");
    }catch(e){
      print("error dey o"+ e.toString());

      // handleError(e);
    }

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
                            Navigator.push(context,    MaterialPageRoute(builder: (context) => CompleteProfileScreen(phone:phoneNo,)));

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
                                builder: (BuildContext context) => CompleteProfileScreen(phone: phoneNo),
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

  Future<void> _submitPhoneNumber() async {
    setState(() {
      isLoading = true;
    });
    /// NOTE: Either append your phone number country code or add in the code itself
    String phoneNumber = cc.dialCode + _phoneNumberController.text.toString().trim();
    phoneNo  = phoneNumber;
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
        _detailsProvider.setMessage("Phone number verified");
        _detailsProvider.setLoading(false);

      this._phoneAuthCredential = phoneAuthCredential;
      _submitOTP(phoneAuthCredential, phoneNumber);
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      _detailsProvider.setLoading(false);
      if(error.code.isNotEmpty){
      _detailsProvider.setMessage(error.code);
      }
      print(error);
    }

    void codeSent(String verificationId, [int code]) {
      _detailsProvider.setMessage("A one time Otp has been sent to you phone");
      _detailsProvider.setLoading(false);

      setState(() {
        isLoading =false;
        smsOTP = code.toString();
      });
      Navigator.pop(context);
      Navigator.push(context,    MaterialPageRoute(builder: (context) => Otp(phoneNo:phoneNumber,verificationId: verificationId,smsOTP: this.smsOTP,phoneAuthCredential: this._phoneAuthCredential,)));
      print('codeSent' + code.toString());
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      _detailsProvider.setLoading(false);

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
    return  Consumer<VerifyUserProvider>(
        builder: (context, data, child) {
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
              margin:EdgeInsets.only(left:20,right:20),
              padding:EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width:1,
                  color: Colors.grey[200],
                ),
              ),
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
                        keyboardType: TextInputType.phone,
                        decoration:InputDecoration(
                            border:InputBorder.none,
                            hintText: 'Enter your phone #'
                        ),
                        onChanged:(value) {
                          setState(() {
                            phoneNo = cc.dialCode+ value;
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
                        child: Center(
                            child:data.isLoading()==false?
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
        }
    );
  }
}
