import 'package:entertainmate/bloc/publish_event/publish_event_bloc.dart';
import 'package:entertainmate/bloc/publish_event/publish_event_event.dart';
import 'package:entertainmate/bloc/publish_event/publish_event_state.dart';
import 'package:entertainmate/screens/description_screen.dart';
import 'package:entertainmate/screens/location_screen.dart';
import 'package:entertainmate/screens/photo_screen.dart';
import 'package:entertainmate/screens/target_audience.dart';
import 'package:entertainmate/screens/title_screen.dart';
import 'package:entertainmate/screens/utility/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NewInPersonEventScreen extends StatefulWidget {
  @override
  _NewInPersonEventScreenState createState() => _NewInPersonEventScreenState();
}

class _NewInPersonEventScreenState extends State<NewInPersonEventScreen> {
  DateTime startDateTime ,endDateTime;

  CreateEventProvider _createEventProvider;
  TextEditingController _titleController= TextEditingController();
  TextEditingController _privacyController= TextEditingController();
  TextEditingController _audienceController= TextEditingController();
  TextEditingController _startDateController= TextEditingController();
  TextEditingController _endDateController= TextEditingController();
  TextEditingController _locationController= TextEditingController();
  TextEditingController _descriptionController= TextEditingController();
 // String _categoryController='';

  PublishEventBloc publishEventBloc;
  @override
  void initState() {
    super.initState ();
    _createEventProvider = Provider.of<CreateEventProvider>(context, listen: false);
    publishEventBloc = BlocProvider.of<PublishEventBloc>(context);


    loadValues();

  }

  Future loadValues(){
    if(_createEventProvider.audience.isNotEmpty){
      _audienceController.text = _createEventProvider.audience;
    }
//    if(_createEventProvider.categoryName.isNotEmpty){
//      _categoryController.text = _createEventProvider.categoryName;
//    }
    if(_createEventProvider.title.isNotEmpty){
      _titleController.text = _createEventProvider.title;
    }
    if(_createEventProvider.peopleCount.toString().isNotEmpty){
      _privacyController.text = _createEventProvider.peopleCount.toString();
    }
    if(_createEventProvider.description.isNotEmpty){
      _descriptionController.text = _createEventProvider.description;
    }
    if(_createEventProvider.startDate.isNotEmpty){
      _startDateController.text = _createEventProvider.startDate;
    }
    if(_createEventProvider.endDate.isNotEmpty){
      _endDateController.text = _createEventProvider.endDate;
    }
    if(_createEventProvider.location.isNotEmpty){
      _locationController.text = _createEventProvider.location;
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
            title: Text ( "New in-person event",
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
                  "Cancel", style: TextStyle ( color: Colors.grey[900] ), ),
              ),
            ),
          ),
          body:
          SingleChildScrollView(
            child: Padding (
              padding: const EdgeInsets.fromLTRB( 0.0, 20.0, 0.0, 10.0 ),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container (
                    color: Colors.white,
                    child: Padding (
                      padding: const EdgeInsets.all( 10.0 ),
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell (
                              onTap: () {
                                Navigator.push (context, MaterialPageRoute ( builder: ( context ) => TitleScreen ( ) ) ).then((value) => {
                                  loadValues()
                                });
                              },
                              child: Padding (
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8 ),
                                child: TextField (
                                  controller: _titleController,
                                  readOnly: true,
                                  style: TextStyle (
                                      fontSize: 16, color: Colors.black ),
                                  decoration:InputDecoration(
                                      hintStyle:TextStyle (
                                          fontSize: 16, color: Colors.grey ) ,
                                      enabled: false,
                                      border:InputBorder.none,
                                      hintText: 'Title'
                                  ),
                                )
                              ) ),
//                          Divider ( color: Colors.grey, ),
//                          Row (
//                            children: [
//                              Icon ( Icons.lock_outline, color: Colors.grey, ),
//                              SizedBox(width:20),
//                              Expanded(
//                                child: TextField (
//                                  controller: _privacyController,
//                                  readOnly: true,
//                                  style: TextStyle (
//                                      fontSize: 16, color: Colors.black ),
//                                  decoration:InputDecoration(
//                                      hintStyle:TextStyle (
//                                          fontSize: 16, color: Colors.grey ) ,
//                                      enabled: false,
//                                      border:InputBorder.none,
//                                      hintText: 'Privacy'
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:45.0,bottom:8),
                            child: Text (
                              data.categoryId<1?"" : 'Category:  ${data.categoryName}',
                              style: TextStyle (
                                  fontSize: 16, color:Colors.grey[700] ),

                            ),
                          ),
                          Divider ( color: Colors.grey, ),
                          InkWell (
                            onTap: (
                                ) {
                              Navigator.push ( context, MaterialPageRoute (
                                  builder: (
                                      context
                                      ) => TargetAudienceScreen ( ) ) ).then((value) => {
                                loadValues()
                              });
                            },
                            child: Row (
                              children: [
                                Icon ( Icons.person_pin, color: Colors.grey, ),
                                SizedBox(width:20),
                                Expanded(
                                  child: TextField (
                                    controller: _audienceController,
                                    readOnly: true,
                                    style: TextStyle (
                                        fontSize: 16, color: Colors.black ),
                                    decoration:InputDecoration(
                                      hintStyle:TextStyle (
                                          fontSize: 16, color: Colors.grey ) ,
                                        enabled: false,
                                        border:InputBorder.none,
                                        hintText: 'Target audience'
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:45.0,bottom:8),
                            child: Text (
                              data.peopleCount<1?"" : 'Looking for  ${data.peopleCount} people',
                              style: TextStyle (
                                  fontSize: 16, color:Colors.grey[700] ),

                            ),
                          ),
                          Divider ( color: Colors.grey, ),
                          Row (
                            children: [
                              Icon ( Icons.calendar_today_rounded,
                                color: Colors.grey, ),
                              SizedBox(width:20),
                              GestureDetector(
                                onTap:(){
                                  setState((){
                                    DatePicker.showDateTimePicker(context, showTitleActions: true,
                                        onChanged: (date) {
                                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                        }, onConfirm: (date) {
                                          startDateTime = date;
                                          data.setStartDate(startDateTime.toString());
                                        }, currentTime: DateTime(2021, 06, 07, 23, 12, 34));
                                  });
                                },
                                child: Text (
                                  data.startDate.isEmpty?"Start date and time" : data.startDate,
                                  style: TextStyle (
                                      fontSize: 16, color: data.startDate.isEmpty?Colors.grey:Colors.black ),

                                ),
                              ),
                            ],
                          ),
                          Divider ( color: Colors.grey, ),
                          Row (
                            children: [
                              Icon ( Icons.calendar_today_outlined,
                                color: Colors.grey, ),
                              SizedBox(width:20),
                              GestureDetector(
                                onTap:(){
                                  setState((){
                                    DatePicker.showDateTimePicker(context, showTitleActions: true,
                                        onChanged: (date) {
                                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                        }, onConfirm: (date) {
                                          endDateTime = date;
                                          data.endDate=(endDateTime.toString());
                                        }, currentTime: DateTime(2021, 06, 07, 23, 12, 34));
                                  });
                                },
                                child: Text (
                                  data.endDate.isEmpty?"End date and time" : data.endDate,
                                  style: TextStyle (
                                      fontSize: 16, color: data.startDate.isEmpty?Colors.grey:Colors.black ),

                                ),
                              ),
                            ],
                          ),
                          Divider ( color: Colors.grey, ),
                          InkWell (
                            onTap: (
                                ) {
                              Navigator.push ( context, MaterialPageRoute (
                                  builder: (
                                      context
                                      ) => LocationScreen ( ) ) ).then((value) => {
                                loadValues()
                              });
                            },
                            child: Row (
                              children: [
                                Icon ( Icons.location_on_outlined,
                                  color: Colors.grey, ),
                                SizedBox(width:20),
                                Expanded (
                                    child: TextField (
                                      controller: _locationController,
                                      readOnly: true,
                                      style: TextStyle (
                                          fontSize: 16, color: Colors.black ),
                                      decoration:InputDecoration(
                                          hintStyle:TextStyle (
                                              fontSize: 16, color: Colors.grey ) ,
                                          enabled: false,
                                          border:InputBorder.none,
                                          hintText: 'Location'
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Divider ( color: Colors.grey, ),
                          InkWell (
                            onTap: (
                                ) {
                              Navigator.push ( context, MaterialPageRoute (
                                  builder: (
                                      context
                                      ) => DescriptionScreen ( ) ) ).then((value) => {
                                loadValues()
                              });
                            },
                            child: Row (
                              children: [
                                Icon ( Icons.create, color: Colors.grey, ),
                                SizedBox(width:20),
                                Expanded (
                                    child: TextField (
                                      controller: _descriptionController,
                                      readOnly: true,
                                      style: TextStyle (
                                          fontSize: 16, color: Colors.black ),
                                      decoration:InputDecoration(
                                          hintStyle:TextStyle (
                                              fontSize: 16, color: Colors.grey ) ,
                                          enabled: false,
                                          border:InputBorder.none,
                                          hintText: 'Description'
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Divider ( color: Colors.grey, ),
                          InkWell (
                            onTap: (
                                ) {
                              Navigator.push ( context, MaterialPageRoute (
                                  builder: (
                                      context
                                      ) => PhotoScreen ( ) ) ).then((value) => {
                                loadValues()
                              });
                            },
                            child: Row (
                              children: [
                                Icon ( Icons.add_a_photo_rounded,
                                  color: Colors.grey, ),
                                SizedBox(width:20),
                                Expanded (
                                  child: Text ( "Photos", style: TextStyle (
                                      fontSize: 16, color: Colors.grey ), ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: Text('Show location to the audience',
                      style: TextStyle(fontSize: 16),),
                    value: data.isLocationShown,
                    activeColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (bool value) {
                      setState(() {
                        data.isLocationShown = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('First interested first added to DM ROOM',
                      style: TextStyle(fontSize: 16),
                    ),
                    value: data.isFirstInterestedAdded,
                    activeColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (bool value) {
                      setState(() {
                        data.isFirstInterestedAdded = value;
                      });
                    },
                  ),

                  Padding (
                    padding: const EdgeInsets.fromLTRB( 10.0, 0.0, 0.0, 10.0 ),
                    child: Container (
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration (
                        shape: BoxShape.circle,
                        color: Colors.black87,
                      ),
                      child: Center ( child: Text ( "UI", style: TextStyle (
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17 ), ) ),

                    ),
                  ),


                  BlocListener<PublishEventBloc, PublishEventState>(
                    listener: (context, state) {
                      if (state is PublishEventInitialState) {
                        Fluttertoast.showToast(
                            msg: "Posting your event...",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } else if (state is PublishEventLoadingState){
                        Fluttertoast.showToast(
                            msg: "Posting your event...",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } else if (state is PostedEventState) {
                        Fluttertoast.showToast(
                            msg: "Your event has been posted",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      } else if (state is PublishEventFailureState) {
                        Fluttertoast.showToast(
                            msg: "Event failed to post, please try again",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    child: Padding (
                        padding: const EdgeInsets.fromLTRB( 10.0, 0.0, 10.0, 0.0 ),
                        child: Container (
                          height: 40,
                          width: MediaQuery.of ( context ).size.width,
                          child: (data.title.isNotEmpty && data.startDate.isNotEmpty && data.endDate.isNotEmpty && data.categoryId.toString().isNotEmpty)?
                          BlocBuilder<PublishEventBloc, PublishEventState>(
                            builder:(context, state) {
                              return MaterialButton(
                                onPressed: () {
                                  publishEventBloc.add(PostingEventEvent());
                                },
                                color: Colors.blueAccent,
                                // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text('Publish',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                          ):

                          MaterialButton (
                            onPressed: () {},
                            color: Colors.lightBlueAccent.shade100.withOpacity (0.9 ),
                            // disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                            child: Text ( 'Publish',
                              style: TextStyle ( color: Colors.grey ), ),
                            shape: RoundedRectangleBorder (
                              borderRadius: BorderRadius.circular ( 10.0 ),
                            ),
                          )
                        ),
                    ),
                     ),


                ],
              ),
            ),
          )
      );
    });
  }
}
