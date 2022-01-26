import 'dart:io';

import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_event.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_state.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/photo_story_screen.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class PhotosWidget extends StatefulWidget {
  List<Images> images;
  String postId;
  PhotosWidget({this.images,this.postId});
  @override
  _PhotosWidgetState createState() => _PhotosWidgetState();
}

class _PhotosWidgetState extends State<PhotosWidget> {
  PostCommentBloc postImageBloc;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    postImageBloc = BlocProvider.of<PostCommentBloc>(context);

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
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    if(image!=null){
      List<File> images = List();
      images.add(image);
    postImageBloc.add(PostImageEvent(postId:widget.postId,images:images ));
    }
  }



   _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    if(image!=null){
      List<File> images = List();
      images.add(image);
      postImageBloc.add(PostImageEvent(postId:widget.postId,images:images ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<PostCommentBloc,PostCommentState>(
      listener: (context,state){
        if(state is PostCommentLoadingState){
          setState(() {
            isLoading=true;
          });
        }else if(state is PostedCommentState){
          print(' getting to posted stats o');
          setState(() {
            isLoading=false;
          });
          // Flushbar(
          //   title:  "Hey Ninja",
          //   message:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
          //   duration:  Duration(seconds: 3),
          // )..show(context);
          Fluttertoast.showToast(
              msg: 'Image uploaded successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );

          setState(() {
            // where state.postId is the image that was just posted
            widget.images.add(new Images(id: '',postId: widget.postId,image: state.postId));
          });
        }
        else if(state is PostCommentFailureState){
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
          setState(() {
            isLoading=false;
          });
        }

        else {
          setState(() {
            isLoading=false;
          });
        }
      },
      child: Scaffold(
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
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
            child: Column(
              children: [
                isLoading==true?Center(child: CircularProgressIndicator()):Container(),
                 photoGridList(),

              ],
            ),
          ),),
        ),
      ),
    );
  }


  Widget photoGridList(){
    return
      Container(
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
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    PhotoStoryScreen(images: widget.images,))
                    );
                  },

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
