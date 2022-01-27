import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utility/create_event_provider.dart';

class DescriptionScreen extends StatefulWidget {
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  CreateEventProvider _provider;
  TextEditingController _descriptionController= TextEditingController();

  @override
  void initState() {
    super.initState ();
    _provider = Provider.of<CreateEventProvider>(context, listen: false);

    if(_provider.title.isNotEmpty){
      _descriptionController.text = _provider.description;
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
            title: Text ( "Description",
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
            padding: const EdgeInsets.fromLTRB( 7.0, 30.0, 7.0, 10.0 ),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding (
                  padding: const EdgeInsets.fromLTRB( 10.0, 0.0, 10.0, 0.0 ),
                  child: Container (
                      height: 48,
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.circular ( 10.0 ),
                        color: Colors.white,
                      ),
                      width: MediaQuery
                          .of ( context )
                          .size
                          .width,
                      child: Padding (
                        padding: const EdgeInsets.only( left: 10.0 ),
                        child: TextField (
                          controller: _descriptionController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration (
                              counterText: "",
                              border: InputBorder.none,
                              prefixIcon: Icon ( Icons.create ),
                              hintText: 'More details about your event',
                              hintStyle: TextStyle (
                                  color: Colors.grey, fontSize: 15 )
                          ),
                          onChanged: ( value ) {
                            data.setDescription(value);
                          },

                        ),
                      )
                  ),
                ),

                Padding (
                  padding: const EdgeInsets.fromLTRB( 7.0, 35.0, 7.0, 13.0 ),
                  child: Container (
                    height: 45,
                    width: MediaQuery
                        .of ( context )
                        .size
                        .width,
                    child: RaisedButton (
                      disabledColor: Colors.grey[200],
                      child: Text ( 'Skip',
                        style: TextStyle ( color: Colors.blue ), ),
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular ( 6.0 ),
                      ),
                    ),
                  ),
                ),

                Padding (
                  padding: const EdgeInsets.fromLTRB( 7.0, 0.0, 7.0, 13.0 ),
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
