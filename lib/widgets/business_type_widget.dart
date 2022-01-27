import 'package:entertainmate/screens/utility/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class BusinessTypeWidget extends StatefulWidget {

  @override
  _BusinessTypeWidgetState createState() => _BusinessTypeWidgetState();
}

class _BusinessTypeWidgetState extends State<BusinessTypeWidget> {
  // bool checkBoxValue = false;
  CreateEventProvider _provider;
  TextEditingController _descriptionController= TextEditingController();
  List<BusinessType> businessType=[];
  List<BusinessType> oldBusinessType=[];
  @override
  void initState() {
    super.initState ();
    _provider = Provider.of<CreateEventProvider>(context, listen: false);
    // if(_provider.title.isNotEmpty){
    //   _descriptionController.text = _provider.description;
    // }

    businessType =  <BusinessType>[
      BusinessType(title: 'Resturant', description: "Own the business", isSelected: false),
      BusinessType(title: 'Arts and Entertainment', description: "Own the business", isSelected: false),
      BusinessType(title: 'Spas and Salons', description: "Own the business", isSelected: false),
      BusinessType(title: 'Health and Medical', description: "Own the business", isSelected: false),
      BusinessType(title: 'Hotels and travels', description: "Own the business", isSelected: false),
      BusinessType(title: 'Education', description: "Own the business", isSelected: false),
      BusinessType(title: 'Services', description: "Own the business", isSelected: false),
      BusinessType(title: 'Religious Organizations', description: "Own the business", isSelected: false),
      BusinessType(title: 'Finance and Investment', description: "Own the business", isSelected: false),
    ];

     oldBusinessType = _provider.businessType;
     // select the ones that has been selected before
    for ( int i=0; i<oldBusinessType.length;i++ ){
      if(oldBusinessType[i].isSelected){
        setState(() {
          businessType[i].isSelected=true;
        });

      }
    }

  }


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
                         // Text(businessType[index].title)
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
              margin:  EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 15.0 ),
              width: MediaQuery.of ( context ).size.width,
              child: (
                  MaterialButton (
                    elevation: 0,
                    onPressed: () {
                      _provider.setBusinessTypes(businessType.where((element) => element.isSelected).toList());
                      Navigator.pop(context);
                    },
                    color: Colors.blueAccent,
                    // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                    child: Text ( 'Done',
                      style: TextStyle ( color: Colors.white ), ),
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