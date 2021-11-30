import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BusinessTypeWidget extends StatefulWidget {

  @override
  _BusinessTypeWidgetState createState() => _BusinessTypeWidgetState();
}

class _BusinessTypeWidgetState extends State<BusinessTypeWidget> {
  // bool checkBoxValue = false;

  List<BusinessType> businessType =  <BusinessType>[
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),
    BusinessType(title: 'Owner/CEO', description: "Own the business", isSelected: false),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Business type?",
            style: TextStyle( fontSize: 17, color: Colors.black87, fontWeight: FontWeight.normal  )),
      ),
      body: Container(
        color: Colors.grey[200],
       padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Text("Select all that applies or best fit \n your business!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500  )
              )),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: businessType.length,
                itemBuilder: (context, index){
                  return Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(businessType[index].title,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500  )
                          ),
                          Text(businessType[index].title)
                        ],
                      ),
                      Spacer(),

                      Checkbox(
                          value: businessType[index].isSelected,
                          activeColor: Colors.blueAccent,
                          onChanged:(bool newValue){
                            setState(() {
                              businessType[index].isSelected = newValue;
                            });
                          })
                    ],
                  );
                },
              ),
            ),


            Container (
              height: 40,
              margin:  EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 10.0 ),
              width: MediaQuery.of ( context ).size.width,
              child: (
                  MaterialButton (
                    elevation: 0,
                    onPressed: () {},
                    color: Colors.lightBlue.shade100,
                    // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                    child: Text ( 'Done',
                      style: TextStyle ( color: Colors.grey ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 5.0 ),
                    ),
                  )
              ),
            ),

          ],
        )

      ),
    );
  }
}



class BusinessType {
  BusinessType({this.title, this.description, this.isSelected});
   String title;
   String description;
   bool isSelected;
}