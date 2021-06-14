import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utility/complete_profile_provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  CompleteProfileProvider _detailsProvider;

  TextEditingController _nameCon = TextEditingController();
  TextEditingController _headlineCon = TextEditingController();
  TextEditingController _bioCon = TextEditingController();
  TextEditingController _faceCon = TextEditingController();
  TextEditingController _insCon = TextEditingController();
  TextEditingController _twiCon = TextEditingController();
  TextEditingController _linCon = TextEditingController();
  TextEditingController _mailCon = TextEditingController();

  bool isUpdateNeeded = false;

  void checkUpdateNeeded(){
    if(_nameCon.text.isNotEmpty ||
        _headlineCon.text.isNotEmpty ||
        _bioCon.text.isNotEmpty  ||
        _faceCon.text.isNotEmpty ||
        _insCon.text.isNotEmpty  ||
        _twiCon.text.isNotEmpty || _linCon.text.isNotEmpty || _mailCon.text.isNotEmpty )
    {
      setState(() {
        isUpdateNeeded = true;
      });
    }else {
      setState(() {
        isUpdateNeeded = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);

  }

  int currentView = 0;
  void changeView(value){
    setState(() {
      currentView=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(color:Colors.grey,icon:Icon( Icons.arrow_back_ios),onPressed: (){Navigator.of(context).pop();},),

        title: Center(child: Text("Edit Info",style: TextStyle(color: Colors.black),)),
        actions: [Center(child: Padding(
          padding: const EdgeInsets.only(right:15.0),
          child: InkResponse(
              onTap: (){
                if(isUpdateNeeded==true){
                  data.updateUserDetails(
                      _nameCon.text ,
                          _headlineCon.text,
                          _bioCon.text,
                          _faceCon.text,
                          _insCon.text ,
                          _twiCon.text, _linCon.text , _mailCon.text
                  );
                }
              },
              child:data.isUserUpdateLoading()?Padding(
                padding: const EdgeInsets.only(right:20.0,left: 10),
                child: SizedBox(height: 20,width: 20, child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),)),
              )
:            Text("Update",style: TextStyle(color: isUpdateNeeded==true? Colors.blue: Colors.grey,fontSize: 18),)),
        ))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: (){changeView(0);},
                    child: Text("Personal Information",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: currentView==0? Colors.blue:Colors.black87),)),
                Container(height: 20,color: Colors.grey[400],width: 1,),
                GestureDetector(
                    onTap: (){changeView(1);},child: Text("Biography",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: currentView==1? Colors.blue:Colors.black87),)),
                Container(height: 20,color: Colors.grey[400],width: 1,),

                GestureDetector(
                    onTap: (){changeView(2);},child: Text("Social Accounts",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: currentView==2? Colors.blue:Colors.black87),)),

              ],
            ),
            SizedBox(height:10),
            Divider(),
            Visibility(
              visible: currentView==0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        height: 170,
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text("Name",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    width: double.infinity,
                                      height: 1,
                                      color: Colors.grey[200],
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text("Headline",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey[200],
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text("Username",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                  ),


                                ],
                              ),
                            ),
                            Container(color: Colors.grey[100],height: 170,width: 1,),
                            Expanded(
                              flex: 9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container (
                                    margin: EdgeInsets.only ( left: 10, right: 10 ),
                                    child: Row (
                                      children: [

                                        Expanded ( child: TextFormField (
                                          onChanged: (
                                              value
                                              ) {
                                            checkUpdateNeeded();
                                          },
                                          decoration: InputDecoration (
                                            border: InputBorder.none,
                                              hintText:data.user.firstname

                                          ),
                                          controller: _nameCon,
                                          readOnly: data.user.isNameChanged==true,
                                        ) )
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey[200],
                                    ),
                                  ),

                                  Container (
                                    margin: EdgeInsets.only ( left: 10, right: 10 ),
                                    child: Row (
                                      children: [

                                        Expanded ( child: TextField (
                                          controller:_headlineCon,
                                          onChanged: (
                                              value
                                              ) {
                                            checkUpdateNeeded();
                                          },
                                          decoration: InputDecoration (
                                            border: InputBorder.none,
                                              hintText:data.user.headline

                                          ),
                                        ) )
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey[200],
                                    ),
                                  ),

                                  Container (
                                    margin: EdgeInsets.only ( left: 10, right: 10 ),
                                    child: Row (
                                      children: [

                                        Expanded ( child: TextFormField (

                                          onChanged: (
                                              value
                                              ) {
                                          },
                                          decoration: InputDecoration (
                                            border: InputBorder.none,
                                              hintText:data.user.username

                                          ), readOnly: true,

                                        ) )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox (
                    height: 8,
                  ),
                  Padding (
                    padding: const EdgeInsets.fromLTRB( 10, 30, 10, 10 ),
                    child: Container (
                      height: 80,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB( 20.0, 10.0, 0, 10.0 ),
                      decoration: BoxDecoration (
                        borderRadius: BorderRadius.all ( Radius.circular ( 10 ) ),
                        color: Colors.blue[50],
                        boxShadow: [
                          BoxShadow (
                            color: Colors.grey.withOpacity ( 0.2 ),
                            spreadRadius: 3,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Center ( child:  RichText(
                        text: TextSpan(
                            text: 'NOTE: ',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue, fontSize: 18,fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(text: 'You can update your name only once. Make sure to choose a proper name',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 16,fontWeight: FontWeight.w400),

                              )
                            ]
                        ),), ),
                    ),
                  ),
                  SizedBox (
                    height: 20,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: currentView==1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Bio",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),


                            ],
                          ),
                        ),
                        Container(color: Colors.grey[100],height: 170,width: 1,),
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container (
                                margin: EdgeInsets.only ( left: 10, right: 10 ),
                                child: Row (
                                  children: [

                                    Expanded ( child:
                                    TextField (
                                      onChanged: (
                                          value
                                          ) {
                                        checkUpdateNeeded();
                                      },
                                      maxLines: 5,
                                      decoration: InputDecoration (
                                        border: InputBorder.none,
                                          hintText:data.user.bio

                                      ),
                                      controller: _bioCon,

                                    ) )
                                  ],
                                ),
                              ),




                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: currentView==2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    height: 250,
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Facebook",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[200],
                              ),

                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("Instagram",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[200],
                              ),


                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("Twitter",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[200],
                              ),


                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("LinkedIn",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[200],
                              ),


                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("Email",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                              ),



                            ],
                          ),
                        ),
                        Container(color: Colors.grey[100],height: 250,width: 1,),
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container (
                                margin: EdgeInsets.only ( left: 10, right: 10 ),
                                child: Row (
                                  children: [

                                    Expanded ( child: TextField (
                                      onChanged: (
                                          value
                                          ) {
                                        checkUpdateNeeded();
                                      },
                                      decoration: InputDecoration (
                                        border: InputBorder.none,
                                          hintText:data.user.facebook

                                      ),
                                      controller: _faceCon,
                                    ) )
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                              ),

                              Container (
                                margin: EdgeInsets.only ( left: 10, right: 10 ),
                                child: Row (
                                  children: [

                                    Expanded ( child: TextField (
                                      onChanged: (
                                          value
                                          ) {
                                        checkUpdateNeeded();        },
                                      decoration: InputDecoration (
                                        border: InputBorder.none,
                                          hintText:data.user.instagram

                                      ),
                                      controller: _insCon,
                                    ) )
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                              ),

                              Container (
                                margin: EdgeInsets.only ( left: 10, right: 10 ),
                                child: Row (
                                  children: [

                                    Expanded ( child: TextField (
                                      onChanged: (
                                          value
                                          ) {
                                        checkUpdateNeeded();
                                      },
                                      decoration: InputDecoration (
                                        border: InputBorder.none,
                                          hintText:data.user.twitter

                                      ),
                                      controller: _twiCon,
                                    ) )
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                              ),
                              Container (
                                margin: EdgeInsets.only ( left: 10, right: 10 ),
                                child: Row (
                                  children: [

                                    Expanded ( child: TextField (
                                      onChanged: (
                                          value
                                          ) {
                                        checkUpdateNeeded();
                                      },
                                      decoration: InputDecoration (
                                        border: InputBorder.none,
                                          hintText:data.user.linkedin

                                      ),
                                      controller: _linCon,

                                    ) )
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                              ),
                              Container (
                                margin: EdgeInsets.only ( left: 10, right: 10 ),
                                child: Row (
                                  children: [

                                    Expanded ( child: TextField (
                                      onChanged: (
                                          value
                                          ) {
                                        checkUpdateNeeded();
                                      },
                                      decoration: InputDecoration (
                                        border: InputBorder.none,
                                          hintText:data.user.email

                                      ),controller: _mailCon,

                                    ) )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],

        ),
      ),

    );
    });
  }
}
