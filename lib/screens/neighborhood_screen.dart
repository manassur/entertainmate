import 'package:flutter/material.dart';


class NeighborhoodScreen extends StatefulWidget {
  @override
  _NeighborhoodScreenState createState() => _NeighborhoodScreenState();
}

class _NeighborhoodScreenState extends State<NeighborhoodScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.grey[300],
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Neighborhood",
              style: TextStyle( fontSize: 18, color: Colors.black87,  fontWeight: FontWeight.bold)),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text("Cancel", style: TextStyle(color: Colors.grey[800]),),
            ),
          ),
          actions: <Widget>[
            Center(child: Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: Text("Done", style: TextStyle(color: Colors.grey),),
            ))
          ],
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top:15.0, bottom:10.0),
              child: Text("Events type",
              style: TextStyle(fontWeight: FontWeight.w600),),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,

              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text("In-person",
                      style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                 Spacer(),
                  Icon(Icons.subdirectory_arrow_right_sharp, color: Colors.blue.shade600,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.7,),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Online",
                  style: TextStyle(fontSize: 17,  fontWeight: FontWeight.w400, color: Colors.grey[700]),),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top:15.0, bottom:10.0),
              child: Text("Distance from address",
                style: TextStyle(fontWeight: FontWeight.w600),),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("10 miles",
                  style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
              ),
            ),
            SizedBox(height: 0.7,),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("2 Andover Rd, Athens, OH",
                  style: TextStyle(fontSize: 17,  fontWeight: FontWeight.w400, color: Colors.blue.shade600),),
              ),
            ),
          ],
        )
    );
  }
}
