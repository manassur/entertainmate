import 'package:flutter/material.dart';
import 'package:flutter_contact/contact.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'screens/utility/complete_profile_provider.dart';

class Phone_Invite extends StatefulWidget {
  @override
  _Phone_InviteState createState() => _Phone_InviteState();
}

class _Phone_InviteState extends State<Phone_Invite> with
    AutomaticKeepAliveClientMixin<Phone_Invite> {
  @override
  bool get wantKeepAlive => true;

  List<Contact> listContacts;
  List<Contact> fullListContacts;
  TextEditingController _searchController = TextEditingController();
  CompleteProfileProvider _detailsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listContacts=new List();
    fullListContacts=new List();
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);

    readContacts();
  }


  readContacts() async
  {

    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Contacts.streamContacts().forEach((contact) {
        if(contact.displayName!=null && contact.displayName!="null" ) {
         // print("${contact.displayName}");
          setState ( ( ) {
            fullListContacts.add ( contact );

          } );
        }
      });
    }
    listContacts = fullListContacts;
    // You can manually adjust the buffer size
    //return  Contacts.streamContacts(bufferSize: 10);

  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
          return Scaffold (
            backgroundColor: Colors.grey[200],
            body: Container (
              width: double.infinity,
              child: Column (

                children: [

                  Container (
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB ( 10, 5, 10, 0 ),
                      child: TextField (
                        controller: _searchController,
                        onChanged: (
                            value
                            ) {
                          List searchResult=fullListContacts.where ( (
                              element
                              ) =>
                          element.displayName != null &&
                              element.displayName.contains ( value ) )
                              .toList ( );

                          setState ( (
                              ) {
                            listContacts=searchResult;
                          } );
                        },
                        decoration: InputDecoration (
                          hintText: 'Search in your phone contacts list',
                          prefixIcon: Icon (
                            Icons.search, color: Colors.grey, ),
                          suffixIcon: Icon (
                            Icons.cancel_outlined, color: Colors.grey, ),
                          hintStyle: TextStyle ( color: Colors.grey ),
                          filled: true,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular( 10.0 ),
                            ),
                            borderSide: BorderSide (
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),

                        ), )
                  ),
                  Expanded (
                    child: Container (

                      child: (listContacts.length > 0) ? ListView.separated (
                          separatorBuilder: (
                              context, index
                              ) {
                            return Divider ( );
                          },
                          itemCount: listContacts.length,
                          itemBuilder: (
                              context, index
                              ) {
                            Contact contact=listContacts.get ( index );
                            return ListTile (
                              leading: CircleAvatar (
                                backgroundColor: Colors.grey,
                                radius: 31,
                                child: CircleAvatar (
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Center (
                                    child: (contact.avatar != null)
                                        ? ClipRRect (
                                        borderRadius: BorderRadius.circular (
                                            30 ),
                                        child: Image.memory ( contact.avatar ) )
                                        : Center ( child: Text (
                                      "${contact.displayName.substring ( 0, 1 )
                                          .toUpperCase ( )}", style: TextStyle (
                                        color: Colors.black87 ), ) ), ), ),
                              )
                              ,
                              title: Text ( "${contact.displayName}" ),
                              subtitle: Text (
                                  (contact.phones.length > 0) ? "${contact
                                      .phones
                                      .get ( 0 )
                                      .value}" : "No contact" ),
                              trailing: Padding (
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 10.0, 10.0, 0 ),
                                child: RaisedButton (
                                  onPressed: (
                                      ) {
                                    if(data.user.invites<5){
                                      data.sendSmsInvite (
                                          contact.phones
                                              .get ( 0 )
                                              .value );
                                    }else{
                                      Fluttertoast.showToast(
                                          msg: 'You have used up your invites',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }

                                  },
                                  child: Text ( 'Invite',
                                    style: TextStyle ( color: Colors.black ), ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder (
                                    borderRadius: BorderRadius.circular (
                                        10.0 ),
                                  )
                                ),
                              ),
                            );
                          } ) : Center ( child: Column (
                        mainAxisSize: MainAxisSize.min,
                        children: [CircularProgressIndicator (
                          backgroundColor: Colors.white, ), Text (
                            "reading Contacts..." )
                        ], ), ),
                    ),
                  ),


                ],
              ),
            ),
          );

        });
  }
}
