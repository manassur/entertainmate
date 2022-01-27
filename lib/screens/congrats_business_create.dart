import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

import '../mate.dart';
class CongratsBusinessCreate extends StatefulWidget {
  CongratsBusinessCreate({this.business});
  String business;
  @override
  _CongratsBusinessCreateState createState() => _CongratsBusinessCreateState();
}

class _CongratsBusinessCreateState extends State<CongratsBusinessCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
              image: AssetImage('images/street.jpg'),
              fit: BoxFit.cover
          ) ,
        ),
        child:   Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 50,),


                  Spacer(),
                  Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(10.0))),


                      child:  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Congratulations!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'You have successfully registered ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.business,
                                      style: TextStyle(
                                          color: Colors.black,fontWeight: FontWeight.w700, fontSize: 17),

                                    )
                                  ]
                              ),),                            SizedBox(
                              height: 10,
                            ),
                            Text('Your business is created and you can add photos,offers/coupons for this business as soon as it has been verified by our team.'),

                            SizedBox(
                              height: 10,
                            ),
                            Text('Cheers,'),
                            Text('ENO Team.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),



                          ],
                        ),
                      )
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: InkResponse(
                          onTap: (){
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => Mate(),
                            //   ),
                            //       (route) => false,
                            // );
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),

                              child: Center(child: Text('GOT IT', style:TextStyle(fontSize: 15.0,color:Colors.white) ,)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )

        ),
    );
  }
}
