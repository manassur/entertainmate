import 'package:entertainmate/widgets/profile_activities_inperson_search.dart';
import 'package:entertainmate/widgets/profile_activities_online_search.dart';
import 'package:flutter/material.dart';


class ActivitiesOffersEvent extends StatefulWidget {

  ActivitiesOffersEvent(
      {Key key});
  @override
  _ActivitiesOffersEventState createState() => _ActivitiesOffersEventState();
}

class _ActivitiesOffersEventState extends State<ActivitiesOffersEvent> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Offers",
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
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return FractionallySizedBox(
                      heightFactor: 0.80,
                    child: ProfileActivitiesOnlineSearch()
                  );
                },
              );
            },
          ),
        ],
      ),

      body: DefaultTabController(
        length: 2,
        child:  Scaffold(
          backgroundColor:Colors.grey[200],
          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child:  Container(
              margin: EdgeInsets.only(top: 1),
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration:BoxDecoration(
                        color:Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                      height: 40,
                      child: Center(
                        child: TabBar(
                            unselectedLabelColor: Colors.black87,
                            labelColor: Colors.black87,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: TextStyle(fontSize: 16),
                            indicator: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.white]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tabs: [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Available"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Expired"),
                                ),
                              ),
                            ]),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          body:  TabBarView(
              children: <Widget>[
                Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        //CONFIRMED
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                        "CONFIRMED (1)",
                                         style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 1,
                                  itemBuilder: (ctx, goingPos) {
                                    return Container(
                                      margin:EdgeInsets.only(bottom: 10.0),
                                      padding: EdgeInsets.fromLTRB( 20.0, 10.0, 20.0, 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1.0, 1.0), //(x,y)
                                              blurRadius: 6.0,
                                              spreadRadius: 1.0
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Half a price ticket ',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16
                                                      )),
                                                  SizedBox(height: 5),

                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Wednessday",
                                                        style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 14,
                                                            color: Colors.grey)),),

                                                      Container(
                                                        height: 5,
                                                        width: 5,
                                                        margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                                        decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                          color: Colors.grey

                                                      ),
                                                      ),

                                                        Text(
                                                        "June 4, 2021",
                                                        style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 14,
                                                            color: Colors.grey
                                                        )),),

                                                    ],
                                                  ),

                                                  SizedBox(height: 5),

                                                  Text("9:00 PM - 12:00 AM", style: TextStyle(fontSize: 13, color: Colors.deepOrange.withOpacity(0.5)),),

                                                  SizedBox(height: 15),

                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(5.0, 3.0, 15.0, 3.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.shade100,
                                                      borderRadius: BorderRadius.circular(13.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          offset: Offset(0.0, 1.0), //(x,y)
                                                          blurRadius: 4.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 13.0,
                                                          backgroundImage: AssetImage("images/entertainmate_pic.jpeg",),
                                                          backgroundColor: Colors.transparent,
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Athena Cinema",  style: TextStyle( fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
                                                            Text("June 1, 2021",  style: TextStyle( fontSize: 10, color: Colors.grey.shade500)),

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,)
                                            ],
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                                            child: Divider(color: Colors.grey),
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Reactions ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                  Text("250",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),
                                              Spacer(),

                                              Row(
                                                children: [
                                                  Text(
                                                      "1K",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                  Text(" Comments", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),

                                              SizedBox(width: 12.0,),

                                              Row(
                                                children: [
                                                  Text(
                                                      "500",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                  Text(" Shares", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        //FOR LIKED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                        "LIKED (2)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder: (ctx, goingPos) {
                                    return Container(
                                      margin:EdgeInsets.only(bottom: 10.0),
                                      padding: EdgeInsets.fromLTRB( 20.0, 10.0, 20.0, 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1.0, 1.0), //(x,y)
                                              blurRadius: 6.0,
                                              spreadRadius: 1.0
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Buy one sub get 50% off',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16
                                                      )),
                                                  SizedBox(height: 5),

                                                  Text(
                                                    "Every Monday",
                                                    style:(TextStyle(fontWeight: FontWeight.w500, fontSize: 14,
                                                        color: Colors.grey)),),

                                                  SizedBox(height: 5),

                                                  Text("1:00 PM - 4:00 PM", style: TextStyle(fontSize: 13, color: Colors.deepOrange.withOpacity(0.5)),),

                                                  SizedBox(height: 15),

                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(5.0, 3.0, 15.0, 3.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.shade100,
                                                      borderRadius: BorderRadius.circular(13.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          offset: Offset(0.0, 1.0), //(x,y)
                                                          blurRadius: 4.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 13.0,
                                                          backgroundImage: AssetImage("images/entertainmate_pic.jpeg",),
                                                          backgroundColor: Colors.transparent,
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Athena Cinema",  style: TextStyle( fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w500)),
                                                            Text("June 1, 2021",  style: TextStyle( fontSize: 10, color: Colors.grey.shade500)),

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,)
                                            ],
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                                            child: Divider(color: Colors.grey),
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Reactions ", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                  Text("250",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),
                                              Spacer(),

                                              Row(
                                                children: [
                                                  Text(
                                                      "1K",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                  Text(" Comments", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                ],
                                              ),

                                              SizedBox(width: 12.0,),

                                              Row(
                                                children: [
                                                  Text(
                                                      "500",
                                                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                                                  Text(" Shares", style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        //FOR SAVED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                        "SAVED (4)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),
                               ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        //FOR INVITED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                        "INVITED (0)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),
                                ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        //FOR COMMENTED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                        "COMMENTED (0)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                      ],
                    ),
                  ),
                ),

                Container(color: Colors.red,),

              ]

          ),
        ),
      ),

    );
  }
}

