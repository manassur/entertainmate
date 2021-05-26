import 'package:flutter/material.dart';

class Phone_Invite extends StatefulWidget {
  @override
  _Phone_InviteState createState() => _Phone_InviteState();
}

class _Phone_InviteState extends State<Phone_Invite> {
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
