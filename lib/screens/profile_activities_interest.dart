import 'package:entertainmate/widgets/interest_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class InterestScreen extends StatefulWidget {
  const InterestScreen({Key key}) : super(key: key);

  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<String> sportInterest = [
    "PickleBall","Badminton", "UI/UX", "Playing guitar", "Indoor soccer", "Volleyball", "Reading/writing poems",
  ];

  int selectedIndex;
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Interests",
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
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Container(
                margin: EdgeInsets.only(top:1.0),
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
                        hintText: 'Search interests in your activities ',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
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

              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 20.0, 10.0, 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing:8.0,
                    runSpacing: 10.0,
                    children: <Widget>[
                      for(String title in sportInterest)
                        InterestWidget(interest: title,
                          textColor:Colors.grey[800] ,
                          color: Colors.white,
                          colorSelected: Colors.grey,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ));

  }
}


