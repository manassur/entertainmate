import 'package:flutter/material.dart';

class SwipeWidget extends StatefulWidget {
  SwipeWidget({this.title,this.description,this.isFirstPage=false});
  String title,description;
  bool isFirstPage;
  @override
  _SwipeWidgetState createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:EdgeInsets.all(20),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.isFirstPage==false,
              child: Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                height: 300,
                width: double.maxFinite,
                child: Card(
                  elevation: 5,
                ),
              ),
            ),
            SizedBox(
                height: 8
            ),
            Spacer(),
            Text(widget.title,
              style: TextStyle(
                fontSize: 23.0, fontWeight: FontWeight.bold,
                color: widget.isFirstPage==true? Colors.white:Colors.black87,
              ),),
            SizedBox(
              height: 8,
            ),
            Text(widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0, fontWeight: FontWeight.normal,
                color:widget.isFirstPage==true? Colors.white:Colors.black87,
              ),),
            SizedBox(
              height: 30,
            ),


          ],
        ),
      ),
    );
  }
}

