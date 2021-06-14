import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EventsItem extends StatefulWidget {
  EventsItem({this.eventName});
  String eventName;
  @override
  _EventsItemState createState() => _EventsItemState();
}

class _EventsItemState extends State<EventsItem> {

  @override
  Widget build(BuildContext context) {

          return     Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    height: 100,
                    width: 170,
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10)),
                    child: Container(
                      color: Colors.black87.withOpacity(0.1),
                      height: 25,
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,5,0,5),
                        child: Text(widget.eventName,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600),),
                      ),
                    )
                ),

              ],
            ),
          );

  }
}
