import 'package:flutter/material.dart';

class PrivateRoomScreen extends StatefulWidget {

  @override
  _PrivateRoomScreenState createState() => _PrivateRoomScreenState();
}

class _PrivateRoomScreenState extends State<PrivateRoomScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        title: Text("Private Room",
            style: TextStyle( fontSize: 15, color: Colors.black38,  )),
      ),

      body: Column(
        children: [
          DefaultTabController(
              length: 5,
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          bottom: TabBar(
                            unselectedLabelColor: Colors.grey[700],
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Colors.blue,
                            labelPadding: EdgeInsets.all(0),
                            tabs: [
                              Tab(
                                text: "Members",
                              ),
                              Tab(
                                text: "Chat",
                              ),
                              Tab(
                                text: "Live stage",
                              ),
                              Tab(
                                text: "Media",
                              ),
                              Tab(
                                text: "Expenses",
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    SingleChildScrollView(
                      child: Container(
                          height: 470, //height of TabBarView SOEMTHING HAS TO BE DONE
                          //ABOUT THIS STATIC HEIGHT FOR THE TABBAR

                          child: TabBarView(children: <Widget>[
                            //MEMBERS TAB
                            Container(
                              child: Text("Members Screen"),
                            ),

                            //CHAT  TAB
                            Container(
                              child: Text("Chat Screen"),
                            ),

                            //LIVE STAGE TAB
                            Container(
                              child: Text("Live Stage Screen"),
                            ),

                            //MEDIA TAB
                            Container(
                              child: Text("Media Screen"),
                            ),

                            //EXPENSES TAB
                            Container(
                              child: Text("Expenses Screen"),
                            ),



                          ])),
                    )
                  ])
          ),

          Spacer(),

          Container(
            color: Colors.grey.shade100,
            padding: EdgeInsets.fromLTRB( 10.0, 7.0, 10.0, 5.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    autofocus: false,
                    style: TextStyle(fontSize: 17.0, color: Color(0XFF2D2D37)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Message here',
                      hintStyle: TextStyle(fontSize: 17.0, color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      // prefixIcon: Container(
                      //   height: 30,
                      //   width: 37 ,
                      //   margin: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //     image: DecorationImage(
                      //       image: AssetImage("images/entertainmate_pic.jpeg", ), fit: BoxFit.cover
                      //     )
                      //   ),
                      // ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.send, color: Colors.grey, size: 35,),
                )
              ],
            ),
          ),


        ],
      ),

    );
  }
}

