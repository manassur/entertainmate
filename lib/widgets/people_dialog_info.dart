import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  // final String title, descriptions, text;
  // final Image img;

  // const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10.0,bottom: 10.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Center(
            child: Container(
              height: 80,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                image:  DecorationImage(
                  image: NetworkImage('https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text("Fei Lu",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 5,),
          Center(
            child: Text("Postdoc at the university of Texas",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,),
          ),
          SizedBox(height: 10,),
          Divider(color: Colors.grey[300],),
          SizedBox(height: 10,),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10.0,bottom: 10.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.lightBlueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.15))

            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text("Fei Lu",
                      style: TextStyle(color: Colors.grey[700], fontSize: 17,fontWeight: FontWeight.w700),),
                  Spacer(),
                    Icon(Icons.more_horiz, color: Colors.grey[800])
                  ],
                ),
                Text("June 3, 2021  12:00 PM",
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  textAlign: TextAlign.center,),
                SizedBox(height: 15,),

                Text("Postdoc at the university of Texas Postdoc at the university of Texas Postdoc at the Texas university of Texas.",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600]),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, color: Colors.grey[500],),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
                      child: Text("12", style: TextStyle(color: Colors.grey[500] ),),
                    ),
                    Icon(Icons.thumb_down_alt_outlined, color: Colors.grey[500],),
                    Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text("3", style: TextStyle(color: Colors.grey[500])),
                    ),
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 20,),
          Text("Show 2 more replies", style: TextStyle(fontSize: 14, color: Colors.grey[600]),),
          SizedBox(height: 13,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image:  DecorationImage(
                    image: NetworkImage('https://i.pinimg.com/originals/97/ed/6b/97ed6b370803649addbf66144c18c194.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, right: 10.0,bottom: 10.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey.withOpacity(0.15))

                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text("Ehsan Doostdar",
                            style: TextStyle( color: Colors.grey[700], fontSize: 17,fontWeight: FontWeight.w700),),
                          Spacer(),
                          Icon(Icons.more_horiz, color: Colors.grey[700])
                        ],
                      ),
                      Text("June 3, 2021  1:30 PM",
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        textAlign: TextAlign.center,),
                      SizedBox(height: 15,),

                      Text("Postdoc at the Texas of some Postdoc at the university of Texas Postdoc at the Texas university of Texas.",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.thumb_up_alt_outlined, color: Colors.grey[500],),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
                            child: Text("2", style: TextStyle(color: Colors.grey[500] ),),
                          ),
                          Icon(Icons.thumb_down_alt_outlined, color: Colors.grey[500],),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0),
                            child: Text(" ", style: TextStyle(color: Colors.grey[500])),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),


          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: FlatButton(
          //       onPressed: (){
          //         Navigator.of(context).pop();
          //       },
          //       child: Text("text",style: TextStyle(fontSize: 18),)),
          // ),
        ],
      ),
    );
  }
}