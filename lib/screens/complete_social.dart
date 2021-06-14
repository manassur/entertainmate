
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CompleteSocial extends StatefulWidget {
  @override
  _CompleteSocialState createState() => _CompleteSocialState();
}

class _CompleteSocialState extends State<CompleteSocial> {
  TextEditingController _facebookController= TextEditingController();
  TextEditingController _instagramController= TextEditingController();
  TextEditingController _twitterController= TextEditingController();
  TextEditingController _emailController= TextEditingController();
  TextEditingController _linkedinController= TextEditingController();
  String fb='',ig='',twi='',email='',linkd='';

  CompleteProfileProvider _detailsProvider;



  @override
  void initState() {
    super.initState ( );
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);


    _facebookController.text='';
    _instagramController.text='';
    _twitterController.text='';
    _emailController.text='';
    _linkedinController.text='';

    if(_detailsProvider.facebook.isNotEmpty){
      _facebookController.text=_detailsProvider.facebook;
      fb = _detailsProvider.facebook;
    }
    if(_detailsProvider.instagram.isNotEmpty){
      _instagramController.text=_detailsProvider.instagram;
      ig = _detailsProvider.instagram;
    }
    if(_detailsProvider.twitter.isNotEmpty){
      _twitterController.text=_detailsProvider.twitter;
      twi = _detailsProvider.twitter;
    }
    if(_detailsProvider.email.isNotEmpty){
      _emailController.text=_detailsProvider.email;
      email = _detailsProvider.email;
    }
    if(_detailsProvider.linkedin.isNotEmpty){
      _linkedinController.text=_detailsProvider.linkedin;
      linkd =_detailsProvider.linkedin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child)
    {
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
                    child: Center ( child: Text (
                      'Link you social accounts, users with more linked account are generally more trusted!',
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
                      SvgPicture.asset (
                        'images/005-instagram.svg', height: 20,
                        width: 15,
                        color:ig.isNotEmpty?Colors.black87: Colors.grey, ),
                      SizedBox(width: 20,),
                      Expanded ( child: TextField (
                        controller: _instagramController,
                        onChanged: (
                            value
                            ) {
                        setState(() {
                          ig = value;
                        });
                        },
                        decoration:InputDecoration(
                            border:InputBorder.none,
                            hintText: 'Instagram'
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


                      SvgPicture.asset (
                        'images/004-twitter.svg', height: 20,
                        width: 15,
                        color:twi.isNotEmpty?Colors.black87: Colors.grey, ),
                      SizedBox(width: 20,),
                      Expanded ( child: TextField (
                        controller: _twitterController,
                        onChanged: (
                            value
                            ) {
                      setState(() {
                        twi = value;
                      });
                        },
                        decoration:InputDecoration(
                            border:InputBorder.none,
                            hintText: 'Twitter'
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


                      SvgPicture.asset (
                        'images/003-facebook.svg', height: 20,
                        width: 15,
                        color:fb.isNotEmpty?Colors.black87: Colors.grey, ),
                      SizedBox(width: 20,),
                      Expanded ( child: TextField (
                        controller: _facebookController,
                        onChanged: (
                            value
                            ) {
                      setState(() {
                        fb = value;
                      });
                        },
                        decoration:InputDecoration(
                            border:InputBorder.none,
                            hintText: 'Facebook'
                        ),

                      ) )
                    ],
                  ),
                ),
                SizedBox (
                  height: 10,
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

                      SvgPicture.asset (
                        'images/002-linkedin-logo.svg', height: 20,
                        width: 15,
                        color:linkd.isNotEmpty?Colors.black87: Colors.grey, ),
                      SizedBox(width: 20,),
                      Expanded ( child: TextField (
                        controller: _linkedinController,
                        onChanged: (
                            value
                            ) {
                      setState(() {
                        linkd = value;
                      });
                        },
                        decoration:InputDecoration(
                            border:InputBorder.none,
                            hintText: 'LinkedIn'
                        ),
                      ) )
                    ],
                  ),
                ),
                SizedBox (
                  height: 10,
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

                      SvgPicture.asset ( 'images/001-email.svg', height: 20,
                        width: 15,
                        color:email.isNotEmpty?Colors.black87: Colors.grey, ),
                      SizedBox(width: 20,),
                      Expanded ( child: TextField (
                        onChanged: (
                            value
                            ) {
                      setState(() {
                        email = value;
                      });
                        },
                        controller: _emailController,
                        decoration:InputDecoration(
                            border:InputBorder.none,
                            hintText: 'Email'
                        ),

                      ) )
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
                        data.setLinks(_facebookController.text, _instagramController.text, _twitterController.text, _linkedinController.text, _emailController.text);
                        data.setCurrentPage(4);
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
                                color: Colors.blue,
                                boxShadow: <BoxShadow>[
                                  BoxShadow (
                                    color: Colors.black54.withOpacity ( 0.2 ),
                                    blurRadius: 8.0,
                                  )
                                ]
                            ),
                            child: Center ( child: Text ( 'Next',
                              style: TextStyle (
                                  fontSize: 15.0, color: Colors.white ), ) ),
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
