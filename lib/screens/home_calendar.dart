import 'package:flutter/material.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({Key key}) : super(key: key);

  @override
  _HomeCalendarState createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Calendar",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back_ios, color: Colors.black)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(top:1.0),
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios, size: 15,),
                  SizedBox(width: 10,),
                  Text("Sunday, August 8, 2021", style: TextStyle(color: Colors.black87),),
                  SizedBox(width: 10,),
                  Icon(Icons.arrow_forward_ios, size: 15,),
                ],
              )
          ),

          Flexible(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 10.0),
                    child: Column(
                      children: [
                        Text("12 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("1 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("2 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("3 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("4 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("5 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("6 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("7 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("8 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("9 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("10 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("11 AM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("12 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("1 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("2 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("3 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("4 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("5 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("6 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                        Text("7 PM",  style: TextStyle(color: Colors.grey[700], fontSize: 15),),
                        SizedBox(height: 40,),
                      ],
                    )
                  ),
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.only(top: 20.0, ),
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                            SizedBox(height: 60,
                                child: Divider(color: Colors.grey,)),
                          ]
                        )
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}

class CalendarWidget extends StatefulWidget {
  final String time;
  const CalendarWidget({Key key, this.time}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
