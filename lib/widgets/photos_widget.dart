import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/utility/constants.dart' as Constants;
import 'package:flutter/material.dart';


class PhotosWidget extends StatefulWidget {
  List<Images> images;
  PhotosWidget({this.images});
  @override
  _PhotosWidgetState createState() => _PhotosWidgetState();
}

class _PhotosWidgetState extends State<PhotosWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
