import 'dart:io';

import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PhotosWidget extends StatefulWidget {
  List<Images> images;
  PhotosWidget({this.images});
  @override
  _PhotosWidgetState createState() => _PhotosWidgetState();
}

class _PhotosWidgetState extends State<PhotosWidget> {
  List<File> _images=List();


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
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
  }



   _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add_a_photo_outlined,color:Colors.black87),
        onPressed: (){
          _showPicker(context);

        },
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down_outlined, size: 25, color: Colors.grey,),
                    Text("Photos added by the moderators",
                      style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),),
                  ],
                ),
              ),

               photoGridList(),

            ],
          ),
        ),),
      ),
    );
  }


  Widget photoGridList(){
    return
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 0.0
            ),
            shrinkWrap: true,
            itemCount: widget.images.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (ctx, pos){
              return Container(
                child: GestureDetector(
                  onTap: () {},

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        image:  DecorationImage(
                          image: NetworkImage(Constants.IMAGE_BASE_URL+widget.images[pos].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );

            },
          ),
        ),
      );

  }

}
