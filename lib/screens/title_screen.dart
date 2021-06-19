import 'package:flutter/material.dart';


class TitleScreen extends StatefulWidget {
  @override
  _TitleScreenState createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  bool _flutter = false;

  String dropdownValue ='Category';


  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.grey[300],
        appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Title",
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
        ),
        body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:InputDecoration(
                            counterText: "",
                            border:InputBorder.none,
                            hintText: 'Title (max 70 character)',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)
                        ),
                        onChanged:(value) {
                          setState(() {
                          });
                        },

                      ),
                    )
                  ),
                ),

                // InkWell(
                //   onTap: (){
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEvent()));
                //
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 0.0),
                //     child: Container(
                //         height: 45,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10.0),
                //           color: Colors.white,
                //         ),
                //         width: MediaQuery.of(context).size.width,
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                //           child: Row(
                //             children: [
                //               Text("Category", style: TextStyle(color: Colors.grey, fontSize: 16),),
                //               Spacer(),
                //               Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.grey,)
                //             ],
                //           ),
                //         )
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 13.0),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 250.0),
                          child: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        iconSize: 15,
                        elevation: 16,
                        style: const TextStyle(color: Colors.grey),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Category','Social', 'Sports', 'Arts', 'Nature']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(child: Text(value, style: TextStyle(),)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 13.0),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton (
                      disabledColor: Colors.lightBlueAccent.withOpacity(0.2),
                      child: Text ( 'Done',
                        style: TextStyle ( color: Colors.grey ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 10.0 ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Divider(color: Colors.grey,),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 35),
                  child: Center(
                    child: Text("Titles you have used before",
                      style: TextStyle(color: Colors.grey, fontSize: 16, letterSpacing: 1) ,),
                  ),
                ),

                Row(
                  children: [
                    Icon(Icons.voice_over_off_outlined, size: 20,),
                    SizedBox(width: 20),
                    Container(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text (
                            "Open discussion about IRAN 1400 presidential election" ,
                            style: TextStyle ( fontSize: 13, fontWeight: FontWeight.w500 ) ,
                            overflow: TextOverflow.ellipsis ,
                            maxLines: 2 ,
                          ),
                          Text("Social", style: TextStyle(color: Colors.grey[700]),)
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey)
                      ),
                        child: Center(child: Text("Update"))
                    ),
                  ],
                ),
                Divider(color: Colors.grey[400]),
                Row(
                  children: [
                    Icon(Icons.voice_over_off_outlined, size: 20,),
                    SizedBox(width: 20),
                    Container(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text (
                            "Outdoor tennis" ,
                            style: TextStyle ( fontSize: 13 , fontWeight: FontWeight.w500) ,
                            overflow: TextOverflow.ellipsis ,
                            maxLines: 2 ,
                          ),
                          Text("Sports", style: TextStyle(color: Colors.grey[500]),)
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Center(child: Text("Update"))
                    ),
                  ],
                ),
                Divider(color: Colors.grey[400], height: 40,),


              ],
            ),
          ),
        )
    );
  }
}
