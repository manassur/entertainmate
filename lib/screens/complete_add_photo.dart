import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CompleteAddPhoto extends StatefulWidget {
  @override
  _CompleteAddPhotoState createState() => _CompleteAddPhotoState();
}

class _CompleteAddPhotoState extends State<CompleteAddPhoto> {
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
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(child: Text('Please tell more about yourself so that friends and community can know who you are!',textAlign: TextAlign.center, style:TextStyle(fontSize: 15.0) ,)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _image != null?
            InkResponse(
                onTap: (){
                  _showPicker(context);
                },
                child:
            Stack(
              alignment: Alignment.bottomCenter,

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _image,
                    height: 300,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ),
          ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10)),
              child: Container(
                color: Colors.black87.withOpacity(0.7),
                height: 40,
                width: 350,
                child: Center(child: Text("Change Photo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
              )
          ),

              ],
            )): InkResponse(
              onTap: (){
                _showPicker(context);
              },
              child:
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white.withOpacity(0.9),
                  border: Border.all(
                    width:1,
                    color: Colors.grey,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 40,
                    width: 150,
                    padding: const EdgeInsets.fromLTRB(5.0, 10.0, 0, 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Colors.white.withOpacity(0.9),
                      border: Border.all(
                        width:1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.library_add),
                        Text("Add Photo")
                      ],
                    ),
                  ),
                ),
              ),
            ),),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkResponse(
                    onTap: (){
                      data.setFile(_image);
                      data.setCurrentPage(4);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: _image!=null ? Colors
                                .blue : Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 8.0,
                              )
                            ]
                        ),
                        child: Center ( child: Text ( 'Next',
                          style: TextStyle ( fontSize: 15.0,
                              color: _image!=null
                                  ? Colors.white
                                  : Colors.blue ), ) ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
        });

  }
}
