import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:entertainmate/bloc/register_business/register_business_bloc.dart';
import 'package:entertainmate/bloc/register_business/register_business_event.dart';
import 'package:entertainmate/screens/congrats_business_create.dart';
import 'package:entertainmate/widgets/business_position_widget.dart';
import 'package:entertainmate/widgets/business_type_widget.dart';
import 'package:entertainmate/widgets/custom_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'utility/create_event_provider.dart';

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
  // social controller
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final linkedInController = TextEditingController();

  // location controller
  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();

  String facebook,instagram;

  // selected position of the busness creator
  int selectedPosition=0;


  RegisterBusinessBloc registerBusinessBloc;
  File _image;



  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  void initState() {
    registerBusinessBloc = BlocProvider.of<RegisterBusinessBloc>(context);
    facebook="";
    if (facebookController.text.isNotEmpty){
      facebook="facebook";
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitDialog(context),

      child: Consumer<CreateEventProvider>(
        builder: (context, data, child)
    { return Scaffold(
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
              onTap: () {
                _showPicker(context);

              },
              child: Container(
                width: 40,
                margin: const EdgeInsets.only(right: 10.0, top: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                  color:  Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.blueAccent)
                  // border: OutlineB
                ),
                child:_image==null? Center(child: Icon(Icons.wb_auto_rounded, color: Colors.grey, size: 25,)):   ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _image,
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                ),
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
                            backgroundColor: Colors.transparent,

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
                             data.businessType.isEmpty?
                             Text("Business type", style: TextStyle(fontSize: 15.0, color: Colors.grey),):
                              Expanded(
                                flex:4,
                                  child: Text(data.businessTypeString.join(','), style: TextStyle(fontSize: 15.0, color: Colors.black),)),
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
                        maxLines: 2,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Description in 5 keywords (sepearate with commas)',
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

                      GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {


                                return CustomAlertDialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("Business Location?",
                                          style: TextStyle( fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        TextField(
                                          controller: street1Controller,
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              hintText: 'Street 1'),
                                        ),

                                        SizedBox(height: 10),

                                        TextField(
                                          controller: street2Controller,
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              hintText: 'Street 2'),
                                        ),

                                        SizedBox(height: 10),

                                        TextField(
                                          controller: cityController,
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              hintText: 'City'),
                                        ),

                                        SizedBox(height: 10),

                                        Row(
                                          children: [
                                            Expanded(
                                              flex:2,
                                              child: TextField(
                                                controller: stateController,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    border: InputBorder.none,
                                                    hintText: 'State'),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex:1,
                                              child: TextField(
                                                controller: zipController,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    border: InputBorder.none,
                                                    hintText: 'Zip code'),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 20),
                                        Container (
                                          height: 40,
                                          margin:  EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 15.0 ),
                                          width: MediaQuery.of ( context ).size.width,
                                          child: (
                                              MaterialButton (
                                                elevation: 0,
                                                onPressed: () {
                                                  data.setBusinessStreet(street1Controller.text,street2Controller.text,cityController.text,stateController.text,zipController.text);
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
                                        )
                                      ],
                                    ),
                                  ),
                                );

                              });
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
                              data.street1.isEmpty?
                              Text("Business Location", style: TextStyle(fontSize: 15.0, color: Colors.grey),):
                              Expanded(
                                flex:4,
                                  child: Text(data.street1, style: TextStyle(fontSize: 15.0, color: Colors.black),)),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_sharp, size: 16, color: Colors.grey,),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        controller: openCloseController,
                        autofocus: false,
                        maxLines: 2,

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
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'More about this business',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),

                          contentPadding: EdgeInsets.all( 15.0),
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


                      GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {

                               return CustomAlertDialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("Social handles",
                                          style: TextStyle( fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        Divider(color: Colors.grey,),
                                        TextField(
                                          controller: instagramController,
                                          
                                          decoration: InputDecoration(
                                            filled: true,
                                              border: InputBorder.none,
                                              hintText: 'Instagram handle'),
                                        ),

                                        SizedBox(height: 10),

                                        TextField(
                                          controller: facebookController,

                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              hintText: 'Facebook handle'),
                                        ),

                                        SizedBox(height: 10),

                                        TextField(
                                          controller:linkedInController,
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              hintText: 'LinkedIn handle'),
                                        ),

                                        SizedBox(height: 20),

                                        Container (
                                          height: 40,
                                          margin:  EdgeInsets.fromLTRB( 10.0, 10.0, 10.0, 15.0 ),
                                          width: MediaQuery.of ( context ).size.width,
                                          child: (
                                              MaterialButton (
                                                elevation: 0,
                                                onPressed: () {
                                                  data.setBusinessSocials(instagramController.text, facebookController.text, linkedInController.text);
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
                                        )
                                      ],
                                    ),
                                  ),
                                );

                              });
                        },

                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.0, 13.0, 15.0, 13.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  SvgPicture.asset (
                                    'images/005-instagram.svg', height: 30,
                                    width: 25,
                                  color:data.instagram.isNotEmpty?Colors.black87: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text("Instagram", style: TextStyle(fontSize: 15.0,color:data.instagram.isNotEmpty?Colors.black87: Colors.grey),),
                                ],
                              ),
                              Column(
                                children: [
                                  SvgPicture.asset (
                                    'images/003-facebook.svg',  height: 30,
                                    width: 25,
                                    color:data.facebook.isNotEmpty?Colors.black87: Colors.grey,
                                    // color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),

                                  Text("Facebook", style: TextStyle(fontSize: 15.0, color:data.facebook.isNotEmpty?Colors.black87: Colors.grey),),
                                ],
                              ),
                              Column(
                                children: [
                                  SvgPicture.asset (
                                    'images/002-linkedin-logo.svg',
                                    height: 30,
                                    width: 25,
                                    color:data.linkedin.isNotEmpty?Colors.black87: Colors.grey,
                              )                                  ,
                                  SizedBox(height: 10),

                                  Text("LinkedIn", style: TextStyle(fontSize: 15.0, color:data.linkedin.isNotEmpty?Colors.black87: Colors.grey),),
                                ],
                              ),

                            ],
                          ),
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
                    onPressed: () async{


                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                return FractionallySizedBox(
                                    heightFactor: 0.5,
                                    child:  Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Container (
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(child: Text("Your position at this business", style: TextStyle(fontSize: 20),)),
                                            Divider(),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedPosition=0;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Owner/CEO",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                      Text("Own the business",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.black87,
                                                    radius: 14,
                                                    child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 13,
                                                        child: CircleAvatar(
                                                          backgroundColor:   selectedPosition==0?Colors.blueAccent:Colors.white,
                                                          radius: 10,

                                                        )
                                                    ),

                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 25),

                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedPosition=1;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Manager ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                      Text("Manage the business ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.black87,
                                                    radius: 14,
                                                    child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 13,
                                                        child: CircleAvatar(
                                                          backgroundColor: selectedPosition==1?Colors.blueAccent:Colors.white,
                                                          radius: 10,

                                                        )
                                                    ),

                                                  )
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 25),

                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedPosition=2;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Employee ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                      Text("Work at the business",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.black87,
                                                    radius: 14,
                                                    child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 13,
                                                        child: CircleAvatar(
                                                          backgroundColor: selectedPosition==2?Colors.blueAccent:Colors.white,
                                                          radius: 10,

                                                        )
                                                    ),

                                                  )
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 25),

                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectedPosition=3;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("Others ",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),
                                                      Text("Any other position not listed above",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400, fontSize: 13),),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.black87,
                                                    radius: 14,
                                                    child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 13,
                                                        child: CircleAvatar(
                                                          backgroundColor: selectedPosition==3?Colors.blueAccent:Colors.white,
                                                          radius: 10,

                                                        )
                                                    ),

                                                  )
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 25),

                                            Divider(),
                                            Spacer(),

                                            GestureDetector(
                                              onTap: () async {
                                                // Navigator.pop(context);
                                                // if(businessNameController.text.isNotEmpty )
                                                //   registerBusinessBloc.add(
                                                //       RegisteringBusinessEvent(
                                                //           name: businessNameController.text,
                                                //           type: "",
                                                //           description: descriptiveController.text,
                                                //           slogan: sloganController.text,
                                                //           phone: phoneController.text,
                                                //           email: emailController.text,
                                                //           location: locationController.text,
                                                //           time: openCloseController.text,
                                                //           website: websiteController.text,
                                                //           more: moreController.text,
                                                //           image: _image
                                                //       ));
                                                //
                                                // else await Flushbar(
                                                //   message: 'Fields cannot be empty',
                                                //   duration: Duration(seconds: 3),
                                                // ).show(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CongratsBusinessCreate(business: businessNameController.text,)),
                                                );

                                              },

                                              child: Container(
                                                height: 50,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.blueAccent,
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: Center(
                                                  child: Text("Continue",
                                                      style: TextStyle( fontSize: 17, color: Colors.white,fontWeight: FontWeight.w500  )),
                                                ),

                                              ),
                                            ),
                                            SizedBox(height: 15),

                                          ],
                                        ),

                                      ),
                                    )
                                );

                              });
                        },
                      );

                    },

                    color: Colors.blueAccent,
                    // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                    child: Text ( 'Continue',
                      style: TextStyle ( color: Colors.white ), ),
                    shape: RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular ( 5.0 ),
                    ),
                  )
              ),
            ),

          ],
        ),
      );
    })
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


