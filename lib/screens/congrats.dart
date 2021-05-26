import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
class Congrats extends StatefulWidget {
  Congrats({this.isRefered,this.referer});
  bool isRefered;
  String referer;
  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
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
                  Text('Welcome to',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22,color: Colors.white),),
              RichText(
                text: TextSpan(
                    text: 'Entertain',
                    style: TextStyle(
                        color: Colors.white, fontSize: 25),
                    children: <TextSpan>[
                      TextSpan(text: 'Mate',
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 25),

                      )
                    ]
                ),),

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
                Visibility(
                    visible: widget.isRefered,
                    child: Text('You have been invited by @'+widget.referer+'!')),
                            SizedBox(
                              height: 10,
                            ),
                            Text('One more step is to finalize your registration. Please continue and complete your profile. We hope you enjoy this app.'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Cheers,'),
                            Text('EntertainMate Team.'),



                          ],
                        ),
                      )
                  ),
                  Spacer(),
                  Visibility(
                    visible:widget.isRefered== true,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkResponse(
                            onTap: (){
                              //   Navigator.push(context,    MaterialPageRoute(builder: (context) => CompleteProfileScreen(phone: widget.phoneNo,)));

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
