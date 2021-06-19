import 'package:flutter/material.dart';


class CommentWidget extends StatefulWidget {
  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_outlined, size: 25, color: Colors.grey,),
                  Text("Comments (10)",
                    style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),),
                ],
              ),
            ),

            commentsList(),

          ],
        ),
      ),);
  }

  Widget commentsList (){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (ctx, pos){
          return Expanded(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      image:  DecorationImage(
                        image: NetworkImage('https://dynaimage.cdn.cnn.com/cnn/c_fill,g_auto,w_1200,h_675,ar_16:9/https%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F210526195007-john-benjamin-thornton.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:5.0),
                      child: Icon(Icons.stars, color: Colors.blue, size: 17,),
                    ),
                    Text("Shamim",
                      style: TextStyle(color:Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16),),
                  ],
                )
              ],
            ),
          );

        },
      );

  }

}
