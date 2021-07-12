import 'dart:io';

import 'package:entertainmate/account_settings.dart';
import 'package:entertainmate/screens/edit_profile.dart';
import 'package:entertainmate/screens/utility/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  CreateEventProvider _createEventProvider;

  List<File> _images=List();
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

//    setState(() {
//      _images.add(image);
//    });
    _createEventProvider.addImage(image);
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

//    setState(() {
//      _images.add(image);
//    });

    _createEventProvider.addImage(image);

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
    super.initState ( );
    _createEventProvider = Provider.of<CreateEventProvider>(context, listen: false);
    if(_createEventProvider.images.isNotEmpty){
      setState(() {
        _images = _createEventProvider.images;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return    Consumer<CreateEventProvider>(
        builder: (context, data, child)
    {
    return Scaffold (
          backgroundColor: Colors.grey[300],
          appBar:  AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text("Photos",
                style: TextStyle( fontSize: 18, color: Colors.black87,  fontWeight: FontWeight.bold)),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                child: Text("Back", style: TextStyle(color: Colors.grey[900]),),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  _showPicker(context);

                },
              )
            ],
          ),
          body:
          Padding(
            padding: const EdgeInsets.fromLTRB(7.0, 30.0, 7.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            shrinkWrap: true,
            itemCount: data.images.length,
            itemBuilder: (ctx, pos) {
              return  Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      data.images[pos],
                      height: 300,
                      width: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10)),
                      child: GestureDetector(
                        onTap:(){

                          data.removeImage(pos);
                        },
                        child: Container(
                          color: Colors.black87.withOpacity(0.7),
                          height: 40,
                          width: 350,
                          child: Center(child: Text("Remove",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),)),
                        ),
                      )
                  ),

                ],
              );
            },
          ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(7.0, 35.0, 7.0, 13.0),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton (
                      disabledColor: Colors.grey[200],
                      child: Text ( 'Skip',
                        style: TextStyle ( color: Colors.blue ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 6.0 ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 13.0),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton (
                      disabledColor: Colors.lightBlueAccent.withOpacity(0.2),
                      child: Text ( 'Done',
                        style: TextStyle ( color: Colors.grey ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 6.0 ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    });
  }
}
