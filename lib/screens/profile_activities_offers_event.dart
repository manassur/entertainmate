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
                            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                         "CONFIRMED (2)",
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

                        //FOR LIKED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Divider(),
                                      Text(
                                        "LIKED (3)",
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

                        //FOR SAVED USERS
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),

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
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
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
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
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

