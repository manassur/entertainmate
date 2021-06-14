//import 'dart:io';
//
//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//class EventsItem extends StatefulWidget {
//  EventsItem({this.contact});
//  Contact contact;
//  @override
//  _EventsItemState createState() => _EventsItemState();
//}
//
//class _EventsItemState extends State<EventsItem> {
//  CompleteProfileProvider _detailsProvider;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ListTile (
//      leading: CircleAvatar (
//        backgroundColor: Colors.grey,
//        radius: 31,
//        child: CircleAvatar (
//          backgroundColor: Colors.white,
//          radius: 30,
//          child: Center (
//            child: (contact.avatar != null)
//                ? ClipRRect (
//                borderRadius: BorderRadius.circular (
//                    30 ),
//                child: Image.memory ( contact.avatar ) )
//                : Center ( child: Text (
//              "${contact.displayName.substring ( 0, 1 )
//                  .toUpperCase ( )}", style: TextStyle (
//                color: Colors.black87 ), ) ), ), ),
//      )
//      ,
//      title: Text ( "${contact.displayName}" ),
//      subtitle: Text (
//          (contact.phones.length > 0) ? "${contact
//              .phones
//              .get ( 0 )
//              .value}" : "No contact" ),
//      trailing: Padding (
//        padding: const EdgeInsets.fromLTRB(
//            30.0, 10.0, 10.0, 0 ),
//        child: RaisedButton (
//          onPressed: (
//              ) {
//            data.sendSmsInvite (
//                contact.phones
//                    .get ( 0 )
//                    .value );
//          },
//          child:data.isSmsInviteLoading()? SizedBox (
//              height: 20,
//              width: 20,
//              child: CircularProgressIndicator (
//                valueColor: new AlwaysStoppedAnimation<Color>(
//                    Colors.blue ), ) ) : Text ( 'Invite',
//            style: TextStyle ( color: Colors.black ), ),
//          color: Colors.white,
//          shape: RoundedRectangleBorder (
//            borderRadius: BorderRadius.circular (
//                10.0 ),
//          ),
//        ),
//      ),
//    );
//  }
//}
