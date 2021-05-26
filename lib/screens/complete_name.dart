import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteName extends StatefulWidget {
  String phone;
  CompleteName({this.phone});
  @override
  _CompleteNameState createState() => _CompleteNameState();
}

class _CompleteNameState extends State<CompleteName> {
  CompleteProfileProvider _detailsProvider;
  TextEditingController _nameController= TextEditingController();
  TextEditingController _headlineController= TextEditingController();

  @override
  void initState() {
    super.initState ( );
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);
  }

    @override
  Widget build(BuildContext context) {
      return  Consumer<CompleteProfileProvider>(
          builder: (context, data, child) {
            return Scaffold (
              body: SingleChildScrollView(
                child: Container (
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      SizedBox (
                        height: 8,
                      ),
                      Padding (
                        padding: const EdgeInsets.fromLTRB( 10, 30, 10, 10 ),
                        child: Container (
                          height: 80,
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(
                              20.0, 10.0, 0, 10.0 ),
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.all (
                                Radius.circular ( 10 ) ),
                            color: Colors.blue[50],
                            boxShadow: [
                              BoxShadow (
                                color: Colors.grey.withOpacity ( 0.2 ),
                                spreadRadius: 3,
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: Center ( child: Text (
                            'Please enter your name,headline,and\n           username to continue!',
                            style: TextStyle ( fontSize: 15.0 ), ) ),
                        ),
                      ),
                      SizedBox (
                        height: 20,
                      ),
                      Container (
                        margin: EdgeInsets.only ( left: 10, right: 10 ),
                        child: Row (
                          children: [

                            Expanded ( child: TextField (
                              controller: _nameController,
                              onChanged: (
                                  value
                                  ) {
//                      setState(() {
//                        smsOTP = value;
//                      });
                              },
                              decoration: InputDecoration (
                                border: OutlineInputBorder ( ),
                                labelText: 'Name',
                              ),

                            ) )
                          ],
                        ),
                      ),
                      SizedBox (
                        height: 20,
                      ),
                      Container (
                        margin: EdgeInsets.only ( left: 10, right: 10 ),
                        child: Row (
                          children: [

                            Expanded ( child: TextField (
                              controller: _headlineController,

                              onChanged: (
                                  value
                                  ) {
//                      setState(() {
//                        smsOTP = value;
//                      });
                              },
                              maxLines: 1,
                              maxLength: 50,
                              decoration: InputDecoration (
                                border: OutlineInputBorder ( ),
                                labelText: 'Headline',
                              ),

                            ) )
                          ],
                        ),
                      ),
                      SizedBox (
                        height: 20,
                      ),
                      Container (
                        margin: EdgeInsets.only ( left: 10, right: 10 ),
                        child: Row (
                          children: [

                            Expanded ( child: TextField (
                              onChanged: (
                                  value
                                  ) {
                                setState ( (
                                    ) {
                                  if ( value.length > 5 ) {
                                    data.setMessage ( "" );
                                    data.setUsername ( value );
                                    data.checkIfUsernameIsAvailable ( );
                                  }
                                  else {
                                    if ( value.isEmpty && ! (value.length > 5) ) {
                                      data.setMessage ( "" );
                                      data.setUsernameAvailable (
                                          false );
                                    }
                                    else {
                                      data.setMessage (
                                          "username too short" );
                                      data.setUsernameAvailable (
                                          false );
                                    }
                                  }
                                } );
                              },
                              maxLength: 50,
                              decoration: InputDecoration (
                                border: OutlineInputBorder ( ),
                                labelText: '@Username',
                              ),

                            ) ),
                          ],
                        ),
                      ),
                      SizedBox (
                        height: 10,
                      ),
                      data.isLoading() == true ? SizedBox (
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator (
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.blue ), ) ) : Container ( ),
                      Text ( data.getMessage ( ), style: TextStyle (
                          fontSize: 17,
                          color: data.isUsernameAvailable == true
                              ? Colors.green
                              : Colors.redAccent ), ),
                      SizedBox (
                        height: 10,
                      ),
                      Row (
                        children: [
                          Expanded (
                            child: InkResponse (
                              onTap: (
                                  ) {
                      if(_nameController.text.isNotEmpty && _headlineController.text.isNotEmpty &&  data.username.isNotEmpty){
                        data.setName(_nameController.text);
                        data.setPhone(widget.phone);
                        data.setHeadline(_headlineController.text);
                        data.saveNames();
                      }else{
                        data.setMessage("please fill in all fields");
                      }
                              },
                              child: Padding (
                                padding: const EdgeInsets.only( top: 20.0 ),
                                child: Container (
                                  margin: EdgeInsets.all ( 5.0 ),
                                  padding: const EdgeInsets.fromLTRB(
                                      30.0, 15.0, 30.0, 15.0 ),
                                  decoration: BoxDecoration (
                                      borderRadius: BorderRadius.all (
                                          Radius.circular ( 5 ) ),
                                      color: data
                                          .isUsernameAvailable == true ? Colors
                                          .blue : Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow (
                                          color: Colors.black54.withOpacity (
                                              0.2 ),
                                          blurRadius: 8.0,
                                        )
                                      ]
                                  ),
                                  child: Center ( child: Text ( 'Next',
                                    style: TextStyle ( fontSize: 15.0,
                                        color: data
                                            .isUsernameAvailable == true &&
                                            data.username.length > 5
                                            ? Colors.white
                                            : Colors.blue ), ) ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          });
  }
}
