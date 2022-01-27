import 'package:flutter/material.dart';

class PersonalProfileFollowing extends StatefulWidget {
  const PersonalProfileFollowing({Key key}) : super(key: key);

  @override
  _PersonalProfileFollowingState createState() => _PersonalProfileFollowingState();
}

class _PersonalProfileFollowingState extends State<PersonalProfileFollowing> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Following",
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
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top:1.0, bottom: 20.0),
              decoration:BoxDecoration(
                color:Colors.white,
              ),
              child:Container(
                margin: EdgeInsets.fromLTRB( 10.0, 15.0, 10.0, 15.0),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: TextField(
                  autofocus: false,
                  controller: searchController,
                  onChanged: (String txt) {},
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search followings ',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400],),
                      suffixIcon: InkWell(
                          onTap: (){
                            searchController.clear();
                          },
                          child: Icon(Icons.cancel, size: 20, color: Colors.grey[400],))
                  ),
                ),
              ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: ListView.separated(
                itemCount: 1,
                itemBuilder: (context, pos){
                  return Row(
                    children: [
                      Container(
                        height: 50, width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          // child: Image.asset("images/sara.jpg", fit: BoxFit.contain,)
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sara Ghanadian",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500)),
                          Text("Data Scientist at Inspired Brands",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ],
                  );
                },

                separatorBuilder: (context, pos){
                  return Divider();
                },
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
