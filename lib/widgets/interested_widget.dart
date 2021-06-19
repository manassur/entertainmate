import 'package:flutter/material.dart';


class InterestedWidget extends StatefulWidget {
  @override
  _InterestedWidgetState createState() => _InterestedWidgetState();
}

class _InterestedWidgetState extends State<InterestedWidget> {

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
                  Text("Interested (5)",
                    style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),),
                ],
              ),
            ),

            interestedList(),

          ],
        ),
      ),);
  }

  Widget interestedList (){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        shrinkWrap: true,
        itemCount: 5,
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
                        image: NetworkImage('https://miro.medium.com/max/1500/1*obNLhNFoyq7hncg1c6HZTg.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text("Micheal",
                  style: TextStyle(color:Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16),)
              ],
            ),
          );

        },
      );

  }

}
