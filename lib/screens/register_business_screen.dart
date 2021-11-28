
import 'package:another_flushbar/flushbar.dart';
import 'package:entertainmate/widgets/business_type_widget.dart';
import 'package:entertainmate/widgets/custom_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterBusinessScreen extends StatefulWidget {

  @override
  _RegisterBusinessScreenState createState() => _RegisterBusinessScreenState();
}

class _RegisterBusinessScreenState extends State<RegisterBusinessScreen> {
  final businessNameController = TextEditingController();
  final descriptiveController = TextEditingController();
  final sloganController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final openCloseController = TextEditingController();
  final websiteController = TextEditingController();
  final moreController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitDialog(context),

      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Register a new business",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              // exitDialog(context);
            },
            child: Container(
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back_ios,color:Colors.black)
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                width: 40,
                margin: const EdgeInsets.only(right: 10.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  color:  Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.blueAccent)
                  // border: OutlineB
                ),
                child: Center(child: Icon(Icons.wb_auto_rounded, color: Colors.grey, size: 25,))
              ),
            )
          ],
        ),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("REQUIRED", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),

                      SizedBox(height: 20),

                      TextField(
                        controller: businessNameController,
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Name of the business',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),

                        ),
                      ),

                      SizedBox(height: 15),

                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.80,
                                        child: BusinessTypeWidget());
                                  });
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.0, 13.0, 15.0, 13.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              Text("Business type", style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      TextField(
                        controller: descriptiveController,
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Descriptive keywords',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: sloganController,
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Business Slogan',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: phoneController,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Business phone number',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: emailController,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Business email address',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: locationController,
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Business Location',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: openCloseController,
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Open/close hours',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      Text("RECOMMENDED", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),

                      SizedBox(height: 20),

                      TextField(
                        controller: websiteController,
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Business Website',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: moreController,
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'More about this business',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1,color: Colors.grey.shade500),
                          ),
                          // suffixIcon: Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),
                        ),
                      ),

                      SizedBox(height: 20),

                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 13.0, 15.0, 13.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Instagram", style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),),
                            Text("Facebook", style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),),
                            Text("LinkedIn", style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),),

                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  )

                ),
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
                    child: Text ( 'Continue',
                      style: TextStyle ( color: Colors.grey ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 5.0 ),
                    ),
                  )
              ),
            ),

          ],
        ),
      ),
    );
  }

  exitDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (context) =>
          CustomAlertDialog(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // SizedBox(height: 15),
              Text("Exit without saving",
                style: TextStyle( fontSize: 18,
              ),
              ),
              SizedBox(height: 10),

              Divider(color: Colors.grey,),

              SizedBox(height: 10),

              Text( "Are you sure you want to exit without saving? You can save it and continue filling the form later.",
                style: TextStyle( fontWeight: FontWeight.w500, fontSize: 14, height: 1.5, wordSpacing: 1
                ),
              ),

              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Container(

                    child: OutlineButton(
                      borderSide: BorderSide(color: Colors.red.shade900,),
                      child: Text( "Exit Anyway",
                        style: TextStyle(color: Colors.red.shade900, fontSize: 16,
                      ),
                      ),
                      onPressed: ()=>Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(width: 20),

                  RaisedButton(
                    child: Text( "Save and exit",
                      style: TextStyle( color: Colors.white, fontSize: 16,
                      ),
                    ),
                    // onPressed: ()=> Navigator.pop(context),
                    onPressed: () async {
                      Navigator.pop(context);

                      await Flushbar(
                        message: 'Details Saved',
                        duration: Duration(seconds: 3),
                      ).show(context);
                    },
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}


