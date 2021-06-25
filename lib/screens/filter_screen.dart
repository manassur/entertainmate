import 'package:flutter/material.dart';


class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.grey[200],
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Filters",
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //sort event
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top:15.0, bottom:10.0),
                child: Text("Sort events by",
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
                      Text("Soonest to latest",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                   Spacer(),
                    Icon(Icons.check, color: Colors.blue.shade600,)
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
                  child: Text("Date Created",
                    style: TextStyle(fontSize: 17,  fontWeight: FontWeight.w400, color: Colors.grey[700]),),
                ),
              ),


              //Availability
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top:15.0, bottom:10.0),
                child: Text("Availability",
                  style: TextStyle(fontWeight: FontWeight.w600),),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Have available seats",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
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
                  child: Row(
                    children: [
                      Text("Full(no available seats)",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),

              //Category
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top:15.0, bottom:10.0, right: 10.0),
                child: Row(
                  children: [
                    Text("Category",
                      style: TextStyle(fontWeight: FontWeight.w600),),
                    Spacer(),
                    Text("Select All",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[500]),),

                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Social",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
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
                  child: Row(
                    children: [
                      Text("Sports",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Arts",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Nature",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),

              //Status
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top:15.0, bottom:10.0, right: 10.0),
                child: Row(
                  children: [
                    Text("Status",
                      style: TextStyle(fontWeight: FontWeight.w600),),
                    Spacer(),
                    Text("Select All",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[500]),),

                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Moderating",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
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
                  child: Row(
                    children: [
                      Text("Co-moderating",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Going",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Interested",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Invited",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Commented",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Saved",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),
              SizedBox(height: 0.7,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Others",
                        style: TextStyle(fontSize: 17, color: Colors.blue.shade600, fontWeight: FontWeight.w400),),
                      Spacer(),
                      Icon(Icons.check, color: Colors.blue.shade600,)
                    ],
                  ),),
              ),

              SizedBox(height: 40),

            ],
          ),
        )
    );
  }
}
