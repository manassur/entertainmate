import 'package:flutter/material.dart';

class CompleteSocial extends StatefulWidget {
  @override
  _CompleteSocialState createState() => _CompleteSocialState();
}

class _CompleteSocialState extends State<CompleteSocial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(child: Text('Link you social accounts, users with more linked account are generally more trusted!', style:TextStyle(fontSize: 15.0) ,)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin:EdgeInsets.only(left:10,right:10),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    onChanged:(value) {
//                      setState(() {
//                        smsOTP = value;
//                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Add Instagram',
                    ),

                  ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin:EdgeInsets.only(left:10,right:10),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    onChanged:(value) {
//                      setState(() {
//                        smsOTP = value;
//                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Add Twitter',
                    ),

                  ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin:EdgeInsets.only(left:10,right:10),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    onChanged:(value) {
//                      setState(() {
//                        smsOTP = value;
//                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Facebook',
                    ),

                  ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin:EdgeInsets.only(left:10,right:10),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    onChanged:(value) {
//                      setState(() {
//                        smsOTP = value;
//                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'LinkedIn',
                    ),

                  ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin:EdgeInsets.only(left:10,right:10),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    onChanged:(value) {
//                      setState(() {
//                        smsOTP = value;
//                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Add Email',
                    ),

                  ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkResponse(
                    onTap: (){
//                      if(_otpController.text.isNotEmpty){
//                        _submitOTP();
//                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color:Colors.blue,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 8.0,
                              )
                            ]
                        ),
                        child: Center(child: Text('Next', style:TextStyle(fontSize: 15.0,color: Colors.white) ,)),
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
