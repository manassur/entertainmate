import 'package:entertainmate/screens/utility/read_more.dart';
import 'package:entertainmate/widgets/comments_widget.dart';
import 'package:entertainmate/widgets/interested_widget.dart';
import 'package:entertainmate/widgets/people_widget.dart';
import 'package:flutter/material.dart';

class HappeningNowScreen extends StatefulWidget {
  @override
  _HappeningNowScreenState createState() => _HappeningNowScreenState();
}

class _HappeningNowScreenState extends State<HappeningNowScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.grey[300],
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Happening Now", style: TextStyle( fontSize: 18, color: Colors.grey[600],  fontWeight: FontWeight.bold)),
          leading: InkWell(onTap: () {Navigator.pop(context);},
            child: Container(
              alignment: Alignment.center,
              child: Text("Back", style: TextStyle(color: Colors.grey[900]),),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              onPressed: () {
              },
            ),
          ],
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:0.3),
                child: Container(
                  color: Colors.white,
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text("Indoor soccer",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ))),
              ),

              Padding (
                padding: EdgeInsets.only (top: 10, bottom: 20 ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:15),

                      Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.access_time, color: Colors.grey,),
                       SizedBox(width:20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Today ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                                Text("7.00 ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                                Text("pm ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                                Text("until ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                                Text("9.00 ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                                Text("pm", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:2.0),
                              child: Text("Thursday, June 4", style: TextStyle(color: Colors.grey[500]),),
                            ),
                          ],
                        ),
                      ],
                    ),
                      SizedBox(height:20),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Colors.grey,),
                          SizedBox(width:20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ping Rec Center ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              Padding(
                                padding: const EdgeInsets.only(top:2.0),
                                child: Text("82 S Green Dr. Athens.OH",
                                  style: TextStyle(color: Colors.grey[800], fontSize: 15, decoration: TextDecoration.underline ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:2.0),
                                child: Text("In-person event", style: TextStyle(color: Colors.grey[500]),),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height:20),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lock_outline, color: Colors.grey,),
                          SizedBox(width:20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Open to the public ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                              Padding(
                                padding: const EdgeInsets.only(top:2.0),
                                child: Text("Looking for 4 people", style: TextStyle(color: Colors.grey[500]),),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height:20),

                      Divider(color: Colors.grey,),
                      SizedBox(height:20),

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.0),
                                  image:  DecorationImage(
                                    image: NetworkImage('https://images.unsplash.com/photo-1568990545613-aa37e9353eb6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2hpdGUlMjBtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              SizedBox( width: 10),

                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text("Brad Winton", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Icon(Icons.stars, color: Colors.blue, size: 17,),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0, 4.5, 0.0, 0.0),
                                      child: Text("Physical education, M.Sc", style: TextStyle(fontSize: 16, color: Colors.grey),),
                                    ),
                                    Row(
                                      children: [
                                        Text("5hr ", style: TextStyle(color: Colors.grey),),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                          child: Container(
                                              height: 16,
                                              width: 16,
                                              child: Image.network("https://cdn3.iconfinder.com/data/icons/faticons/32/globe-01-512.png")),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 18,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),

                                ),
                              ),

                              SizedBox( width: 10),

                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Column(
                                      children: [
                                        ReadMoreText(
                                          "Lorem ipsum dolor sit amet, something for lorem Lorem ipsum dolor sit amet, something Lorem ipsum dolor sit amet, something lorem ipsum dolor omething lorem ipsum dolor omething lorem ipsum dolor",
                                          trimLines: 3,
                                          colorClickableText: Colors.grey.withOpacity(0.9),
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: '...See More',
                                          trimExpandedText: ' See Less',
                                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 80,
                      height: 26,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15.0),
                         color: Colors.lightBlueAccent.withOpacity(0.2),
                       ),
                      child: Center(child: Text("People",
                          style: TextStyle(color: Colors.blue, letterSpacing:1 , fontWeight: FontWeight.w500),))
                  ),

                  Container(
                      width: 80,
                      height: 26,
                      child: Center(child: Text("Photos",
                        style: TextStyle(color: Colors.grey[800], letterSpacing:1, fontWeight: FontWeight.w500 ),))
                  ),
                  Container(
                      width: 80,
                      height: 26,
                      child: Center(child: Text("Details",
                        style: TextStyle(color: Colors.grey[800], letterSpacing:1, fontWeight: FontWeight.w500 ),))
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 20.0),
                child: Divider(color: Colors.grey[400]),
              ),

              PeopleWidget(),

              InterestedWidget(),

              CommentWidget(),

            ],
          ),
        ),

    );
  }
}
