import 'package:entertainmate/widgets/people_dialog_info.dart';
import 'package:flutter/material.dart';


class PeopleWidget extends StatefulWidget {
  @override
  _PeopleWidgetState createState() => _PeopleWidgetState();
}

class _PeopleWidgetState extends State<PeopleWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.keyboard_arrow_down_outlined, size: 25, color: Colors.grey,),
              Text("Going (2 out of 4)",
                style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),),
            ],
          ),

           peopleList(),

        ],
      ),
    ),);
  }

  Widget peopleList (){
    return
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (ctx, pos){
          return Expanded(
            child: GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => CustomDialogBox()
              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 6.0),
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        image:  DecorationImage(
                          image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUmNfQXFzD5vLQlTtEkXH8hMKw2OzKjAkEog&usqp=CAU'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Adri",
                    style: TextStyle(color:Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16),)
                ],
              ),
            ),
          );

        },
      );

  }

}
