import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'utility/create_event_provider.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  String apiKey='AIzaSyCodGlfgpWq40U-imbTrwnPgEQ06Y-Fd_o';
  CreateEventProvider _provider;
  TextEditingController _locationController= TextEditingController();

  @override
  void initState() {
    super.initState ();
    _provider = Provider.of<CreateEventProvider>(context, listen: false);

    if(_provider.title.isNotEmpty){
      _locationController.text = _provider.location;
    }


    googlePlace = GooglePlace(apiKey);
  }

  void autoCompleteSearch(String value) async {
    print('autoCompletcalled');
    var result = await googlePlace.autocomplete.get(value);
    print('result' + result.status);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
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
            title: Text ( "Location",
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
                Text (
                    "Search for a place name or physical address you wish to hold your event at. You must at least select the city and state.",
                    style: TextStyle (
                        color: Colors.grey[700], fontSize: 18, height: 1.5 ) ),
                Text (
                  "If our search engine could not find the place by its name, you may enter the exact address or just select the City and State then name the place in the next step, manually.",

                  style: TextStyle ( height: 1.5,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16 ), ),
                Padding (
                  padding: const EdgeInsets.fromLTRB( 10.0, 50.0, 10.0, 0.0 ),
                  child: Container (
                      height: 45,
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular ( 10.0 ),
                        color: Colors.white,
                      ),
                      width: MediaQuery
                          .of ( context )
                          .size
                          .width,
                      child: GestureDetector(
                        onTap: () async{
                          var googlePlace = GooglePlace("Your-Key");
                          var result = await googlePlace.search.getFindPlace(
                              "Museum of Contemporary Art Australia", InputType.TextQuery);
                        },
                        child: TextField (
                          controller: _locationController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration (
                              counterText: "",
                              border: InputBorder.none,
                              prefixIcon: Icon ( Icons.search, size: 20, ),
                              hintText: 'Search here',
                              hintStyle: TextStyle (
                                  color: Colors.grey, fontSize: 17 )
                          ),
                          onChanged: (value) {
                          if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                          } else {
                          if (predictions.length > 0 && mounted) {
                          setState(() {
                          predictions = [];
                          });
                          }
                          }
                            data.setLocation(value);
                          },

                        ),
                      )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return       Row (
                        children: [
                          Icon ( Icons.warning, size: 20, ),
                          SizedBox ( width: 20 ),
                          Container (
                            width: 230,
                            child: Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text (predictions[index].description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle (
                                      color: Colors.grey[700], fontSize: 15 ), )
                              ],
                            ),
                          ),
                          Spacer ( ),
                          GestureDetector(
                            onTap:(){},
                            child: Container (
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration (
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular ( 10.0 ),
                                    border: Border.all ( color: Colors.grey )
                                ),
                                child: Center ( child: Text (
                                  "Select", style: TextStyle ( fontSize: 12 ), ) )
                            ),
                          ),
                        ],
                      );

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text('powered by Google'),
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
                      child: Text ( 'Next',
                        style: TextStyle ( color: Colors.grey ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 10.0 ),
                      ),
                    ),
                  ),
                ),

                Padding (
                  padding: const EdgeInsets.all( 11.0 ),
                  child: Divider ( color: Colors.grey, ),
                ),

                Padding (
                  padding: const EdgeInsets.only( top: 10.0, bottom: 35 ),
                  child: Center (
                    child: Text ( "Locations you have selected before",
                      style: TextStyle ( color: Colors.grey,
                          fontSize: 16,
                          letterSpacing: 1 ), ),
                  ),
                ),

                Row (
                  children: [
                    Icon ( Icons.warning, size: 20, ),
                    SizedBox ( width: 20 ),
                    Container (
                      width: 230,
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text ( "2 Andover Rd, Athens, OH 45701",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle (
                                color: Colors.grey[700], fontSize: 15 ), )
                        ],
                      ),
                    ),
                    Spacer ( ),
                    Container (
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration (
                            color: Colors.white,
                            borderRadius: BorderRadius.circular ( 10.0 ),
                            border: Border.all ( color: Colors.grey )
                        ),
                        child: Center ( child: Text (
                          "Select", style: TextStyle ( fontSize: 12 ), ) )
                    ),
                  ],
                ),
                Divider ( color: Colors.grey[400] ),
                Row (
                  children: [
                    Icon ( Icons.warning, size: 20, ),
                    SizedBox ( width: 20 ),
                    Container (
                      width: 230,
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text (
                            "Ping Rec Center",
                            style: TextStyle ( color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w500 ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Padding (
                            padding: const EdgeInsets.only( top: 5.0 ),
                            child: Text ( "82 S Green Dr, Athens, OH 45701",
                              style: TextStyle ( color: Colors.grey[600] ), ),
                          )
                        ],
                      ),
                    ),
                    Spacer ( ),
                    Container (
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration (
                            color: Colors.white,
                            borderRadius: BorderRadius.circular ( 10.0 ),
                            border: Border.all ( color: Colors.grey )
                        ),
                        child: Center ( child: Text (
                          "Select", style: TextStyle ( fontSize: 12 ), ) )
                    ),
                  ],
                ),
                Divider ( color: Colors.grey[400], height: 40, ),


              ],
            ),

      )
      );
    });
  }
}
