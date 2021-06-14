import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _usernameController= TextEditingController();

  @override
  void initState() {
    super.initState ();
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);
    if(_detailsProvider.username.isNotEmpty){
      _usernameController.text = _detailsProvider.username;
    }
    if(_detailsProvider.headline.isNotEmpty){
      _nameController.text = _detailsProvider.headline;
    }
    if(_detailsProvider.name.isNotEmpty){
      _headlineController.text = _detailsProvider.name;
    }
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
                        margin:EdgeInsets.only(left:20,right:20),
                        padding:EdgeInsets.symmetric(horizontal:20,vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            width:1,
                            color: Colors.grey[300],
                          ),),
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
                              decoration:InputDecoration(
                                  border:InputBorder.none,
                                  hintText: 'Name'
                              ),
                            ) )
                          ],
                        ),
                      ),
                      SizedBox (
                        height: 20,
                      ),
                      Container (
                        margin:EdgeInsets.only(left:20,right:20),
                        padding:EdgeInsets.symmetric(horizontal:20,vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            width:1,
                            color: Colors.grey[300],
                          ),),
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
                              decoration:InputDecoration(
                                  border:InputBorder.none,
                                  hintText: 'Headline'
                              ),

                            ) )
                          ],
                        ),
                      ),
                      SizedBox (
                        height: 20,
                      ),
                  Padding(
                    padding: const EdgeInsets.only(right:30.0),
                    child: Row (
                      mainAxisAlignment:MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Text ( data.getMessage ( ), style: TextStyle (
                              fontSize: 13,
                              color: data.isUsernameAvailable == true
                                  ? Colors.green
                                  : Colors.redAccent ), ),
                        ),
                        data.isLoading() == true ? SizedBox (
                            height: 13,
                            width: 13,
                            child: CircularProgressIndicator (
                              strokeWidth: 1,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.grey ), ) ) : Container ( ),

                      ]),
                  ),
                      SizedBox (
                        height: 8,
                      ),
                      Container (
                        margin:EdgeInsets.only(left:20,right:20),
                        padding:EdgeInsets.symmetric(horizontal:20,vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            width:1,
                            color: Colors.grey[300],
                          ),),
                        child: Row (
                          children: [

                            Expanded ( child: TextField (
                              keyboardType: TextInputType.text,
                              controller: _usernameController,
                              onChanged: (
                                  value
                                  ) {
                                setState ( (
                                    ) {
                                  if ( value.length > 5 ) {
                                    data.setMessage ( "checking username...." );
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
                              decoration:InputDecoration(
                                  border:InputBorder.none,
                                  hintText: '@Username'
                              ),
                              inputFormatters: [BlacklistingTextInputFormatter(
                                  new RegExp(r"\s\b|\b\s")
                              )],
                            ) ),
                          ],
                        ),
                      ),
                      SizedBox (
                        height: 10,
                      ),


                      Row (
                        children: [
                          Expanded (
                            child: InkResponse (
                              onTap: (
                                  ) {
                                // check if username has been made available
                                if(data.isUsernameAvailable==true){
                      if(_nameController.text.isNotEmpty && _headlineController.text.isNotEmpty &&  data.username.isNotEmpty){
                        data.setName(_nameController.text);
                        data.setPhone(widget.phone);
                        data.setHeadline(_headlineController.text);
                        data.saveNames();
                      }else{
                        data.setMessage("please fill in all fields");
                      }}else{
                                  data.setMessage("please try a different username");
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
