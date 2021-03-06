import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utility/create_event_provider.dart';


class TargetAudienceScreen extends StatefulWidget {
  @override
  _TargetAudienceScreenState createState() => _TargetAudienceScreenState();
}

class _TargetAudienceScreenState extends State<TargetAudienceScreen> {
  bool _flutter = false;


  CreateEventProvider _provider;
  TextEditingController _peopleCountController= TextEditingController();
  TextEditingController _audienceController= TextEditingController();

  @override
  void initState() {
    super.initState ();
    _provider = Provider.of<CreateEventProvider>(context, listen: false);

    if(_provider.title.isNotEmpty){
      _peopleCountController.text = _provider.peopleCount.toString();
    }
    if(_provider.audience.isNotEmpty){
      _audienceController.text = _provider.audience;
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<CreateEventProvider>(
        builder: (context, data, child)
    {
      return Scaffold (
          backgroundColor: Colors.grey[300],
          appBar: AppBar (
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text ( "Target Audience",
                style: TextStyle ( fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold ) ),
            leading: InkWell (
              onTap: (
                  ) {
                Navigator.pop ( context );
              },
              child: Container (
                alignment: Alignment.center,
                child: Text (
                  "Back", style: TextStyle ( color: Colors.grey[900] ), ),
              ),
            ),
          ),
          body:
          Padding (
            padding: const EdgeInsets.fromLTRB( 10.0, 25.0, 10.0, 10.0 ),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text ( "Who do you wish to attend this event?",
                  style: TextStyle ( fontSize: 18 ), ),
                Padding (
                  padding: const EdgeInsets.only( top: 10.0, bottom: 20.0 ),
                  child: Text ( "You can invite people later",
                    style: TextStyle (
                        fontWeight: FontWeight.bold, fontSize: 17 ), ),
                ),
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text ( "Open to" ),
                    Padding (
                      padding: const EdgeInsets.fromLTRB(
                          10.0, 0.0, 10.0, 0.0 ),
                      child: Container (
                          height: 45,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular ( 10.0 ),
                            color: Colors.white,
                          ),
                          width: 300,
                          child: Padding (
                            padding: const EdgeInsets.only( left: 10.0 ),
                            child: TextField (
                              controller: _audienceController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration (
                                  counterText: "",
                                  border: InputBorder.none,
                                  suffixIcon: Icon (
                                    Icons.info_outline, size: 14,
                                    color: Colors.grey, ),
                                  hintText: 'Public',
                                  hintStyle: TextStyle (
                                      color: Colors.grey, fontSize: 15 )
                              ),
                                onChanged: (value){
                                  data.setAudience(value);
                                }

                            ),
                          )
                      ),
                    ),
                  ],
                ),

                SizedBox ( height: 20 ),

                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text ( "Looking for this number of people:" ),
                        Text ( 'Leave it empty if there is no limit.',
                          style: TextStyle ( color: Colors.blue ), ),
                      ],
                    ),
                    Padding (
                      padding: const EdgeInsets.fromLTRB(
                          10.0, 0.0, 10.0, 0.0 ),
                      child: Container (
                          height: 45,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular ( 10.0 ),
                            color: Colors.white,
                          ),
                          width: 100,
                          child: Padding (
                            padding: const EdgeInsets.only( left: 10.0 ),
                            child: TextField (
                              controller: _peopleCountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration (
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: '',
                                  hintStyle: TextStyle (
                                      color: Colors.grey, fontSize: 15 )
                              ),
                                onChanged: (value){
                                  if(value=='0'){
                                    _peopleCountController.text = '';
                                  }else{
                                    data.setPeopleCount(value);
                                  }

                                }

                            ),
                          )
                      ),
                    ),
                  ],
                ),


                Padding (
                  padding: const EdgeInsets.fromLTRB( 10.0, 40.0, 10.0, 13.0 ),
                  child: Container (
                    height: 45,
                    width: MediaQuery
                        .of ( context )
                        .size
                        .width,
                    child: RaisedButton (
                      disabledColor: Colors.lightBlueAccent.withOpacity ( 0.2 ),
                      child: Text ( 'Done',
                        style: TextStyle ( color: Colors.grey ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 10.0 ),
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
