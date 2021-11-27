
import 'package:entertainmate/bloc/publish_event/publish_event_bloc.dart';
import 'package:entertainmate/bloc/publish_event/publish_event_event.dart';
import 'package:entertainmate/bloc/publish_event/publish_event_state.dart';
import 'package:entertainmate/screens/create_event.dart';
import 'package:entertainmate/screens/description_screen.dart';
import 'package:entertainmate/screens/location_screen.dart';
import 'package:entertainmate/screens/photo_screen.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/target_audience.dart';
import 'package:entertainmate/screens/title_screen.dart';
import 'package:entertainmate/screens/utility/create_event_provider.dart';
import 'package:entertainmate/widgets/exit_alert_dialog.dart';
import 'package:entertainmate/widgets/rounded_container_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewInPersonEventScreen extends StatefulWidget {
  final int type,clas;
  NewInPersonEventScreen({this.type,this.clas});
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
  String odropdownValue ='Open to public';
  var odropDownItems=<String>[
    'Open to public',
    'Invited guests only',

  ];

  String dropdownValue ='Category';
  var dropDownItems=<String>[
    'Category',
    'Social',
    'Sports',
    'Arts',
    'Nature'
  ];
  CreateEventProvider _provider;
  PublishEventBloc publishEventBloc;
  @override
  void initState() {
    super.initState ();
    _createEventProvider = Provider.of<CreateEventProvider>(context, listen: false);
    publishEventBloc = BlocProvider.of<PublishEventBloc>(context);


    loadValues();

  }

  Future loadValues(){

    _createEventProvider.setEventType(widget.type);
    _createEventProvider.setPeopleCount(widget.clas);
    if(_createEventProvider.audience.isNotEmpty){
      odropdownValue = _createEventProvider.audience;
    }

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
    if(_createEventProvider.categoryName.isNotEmpty){
      dropdownValue = _createEventProvider.categoryName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<CreateEventProvider>(
        builder: (context, data, child)
    {
      return Scaffold (
          backgroundColor: Colors.white,

          appBar: AppBar (
            backgroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
            title: Text ( "New in-person event",
                style: TextStyle ( fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500 ) ),

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
                              child: RoundedContainerBg(
                                child: Padding (
                                  padding: const EdgeInsets.only( left: 8.0 ),
                                  child: TextField (
                                    controller:_titleController,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value){
                                      data.setTitle(value);
                                    },
                                    decoration: InputDecoration (
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: 'Title (max 70 character)',
                                        hintStyle: TextStyle ( color: Colors.grey,
                                            fontSize: 15 )
                                    ),

                                  ),
                                ),
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
//                          ),                            SizedBox(width: 10),
                          SizedBox(height: 10),
                          RoundedContainerBg(
                            child: Container(
                              width: double.infinity,
                              child: Padding (
                                padding: const EdgeInsets.all( 8.0 ),
                                child: DropdownButton<String> (
                                  value: dropdownValue,
                                  isExpanded: true,
                                  hint: Text (
                                    'Category', style: TextStyle (color: Colors.grey), ),
                                  icon: const Icon( Icons
                                      .arrow_drop_down ),
                                  iconSize: 15,
                                  elevation: 16,
                                  style: const TextStyle( color: Colors.grey ),
                                  underline: Container (
                                    height: 0,
                                  ),
                                  onChanged: (
                                      String newValue
                                      ) {
                                    setState ( (
                                        ) {
                                      dropdownValue=newValue;
                                    } );
                                    data.setCategoryName(dropdownValue);
                                    data.setCategoryId(dropDownItems.indexOf(dropdownValue));
                                  },
                                  items: dropDownItems
                                      .map<DropdownMenuItem<String>> ( (
                                      String value
                                      ) {
                                    return DropdownMenuItem<String> (
                                      value: value,
                                      child: Text (
                                        value, style: TextStyle (color: Colors.black87), ),
                                    );
                                  } ).toList ( ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 10),
                          RoundedContainerBg(
                            child: Container(
                              width: double.infinity,
                              child: Padding (
                                padding: const EdgeInsets.all( 8.0 ),
                                child: DropdownButton<String> (
                                  value: odropdownValue,
                                  isExpanded: true,
                                  hint: Text (
                                    'Open to', style: TextStyle (color: Colors.grey), ),
                                  icon: const Icon( Icons
                                      .arrow_drop_down ),
                                  iconSize: 15,
                                  elevation: 16,
                                  style: const TextStyle( color: Colors.grey ),
                                  underline: Container (
                                    height: 0,
                                  ),
                                  onChanged: (
                                      String newValue
                                      ) {
                                    setState ( (
                                        ) {
                                      odropdownValue=newValue;
                                    } );
                                    data.setAudienceId(odropDownItems.indexOf(odropdownValue));
                                    data.setAudience(odropdownValue);
                                  },
                                  items: odropDownItems
                                      .map<DropdownMenuItem<String>> ( (
                                      String value
                                      ) {
                                    return DropdownMenuItem<String> (
                                      value: value,
                                      child: Text (
                                        value, style: TextStyle (color: Colors.black87), ),
                                    );
                                  } ).toList ( ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RoundedContainerBg(
                              child: Padding (
                                  padding: const EdgeInsets.all(
                                      10),
                                  child:   Text(widget.type==0? "New in-person event": "Online",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),

                              ),
                            ),
                          ),
                          SizedBox(width: 10),
              Expanded(
                child: RoundedContainerBg(
                  child: Padding (
                    padding: const EdgeInsets.all(
                        10),
                    child:   Text(widget.clas==0? "Non- Anonymmous": "Anonymous",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 15),),

                  ),
                ),
              ),
                        ],
                      ),
                          SizedBox(height: 10),
                          Row (
                            crossAxisAlignment: CrossAxisAlignment.center ,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap:(){
                                    setState((){
                                      DatePicker.showDateTimePicker(context, showTitleActions: true,
                                          onChanged: (date) {
                                            print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                          }, onConfirm: (date) {
                                            startDateTime = date;
                                            data.setStartDate(DateFormat('HH:mma yyyy-MM-dd').format(startDateTime));
                                          }, currentTime: DateTime.now());
                                    });
                                  },
                                  child: RoundedContainerBg(
                                    child: Center(
                                      child: Text (
                                        data.startDate.isEmpty?"Start date" : data.startDate,
                                        style: TextStyle (
                                            fontSize: 14, fontWeight: FontWeight.w500,color: data.startDate.isEmpty?Colors.grey:Colors.black ),

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width:10),
                              Expanded(
                                child: GestureDetector(
                                  onTap:(){
                                    setState((){
                                      DatePicker.showDateTimePicker(context, showTitleActions: true,
                                          onChanged: (date) {
                                            print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                          }, onConfirm: (date) {
                                            endDateTime = date;
                                            data.setEndDate(DateFormat('HH:mma yyyy-MM-dd').format(endDateTime));
                                          }, currentTime: DateTime.now());
                                    });
                                  },
                                  child: RoundedContainerBg(
                                    child: Center(
                                      child: Text (
                                        data.endDate.isEmpty?"End date" : data.endDate,
                                        style: TextStyle (
                                            fontSize: 14,fontWeight: FontWeight.w500, color: data.startDate.isEmpty?Colors.grey:Colors.black ),

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:10),
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
                            child: RoundedContainerBg(
                              child: Row (
                                children: [
                                  Expanded (
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                              hintText: 'Location (optional)'
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          RoundedContainerBg(
                            child: Row (
                              children: [
                                Expanded (
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child:TextField (
                                        controller: _descriptionController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration (
                                            counterText: "",
                                            border: InputBorder.none,
                                            hintText: 'More details (optional)',
                                            hintStyle: TextStyle (
                                                color: Colors.grey, fontSize: 15 )
                                        ),
                                        onChanged: ( value ) {
                                          data.setDescription(value);
                                        },

                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),



                  BlocListener<PublishEventBloc, PublishEventState>(
                    listener: (context, state) {
                      if (state is PublishEventInitialState) {
                        // Fluttertoast.showToast(
                        //     msg: "Posting your event...",
                        //     toastLength: Toast.LENGTH_LONG,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     backgroundColor: Colors.blue,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0
                        // );
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
                        ).then((value) => Navigator.of(context).pop());
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
                                child:(state is PublishEventLoadingState)?
                                SizedBox(
                                  height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),)) :Text('Post',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                          ):

                          MaterialButton (
                            color: Colors.lightBlueAccent.shade100.withOpacity (0.2 ),
                           disabledColor: Colors.lightBlueAccent.withOpacity(0.1),
                            child: Text ( 'Post',
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

  // exitDialog(BuildContext context){
  //   showDialog(
  //     context: context,
  //     builder: (context) => ExitAlertDialog(
  //       child: Padding(
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Text( "Leave without publishing?",
  //               style: TextStyle(color: Colors.grey[600],  fontSize: 17),
  //             ),
  //
  //             SizedBox(height: 7,),
  //             Divider(color: Colors.grey[300],),
  //             SizedBox(height: 8,),
  //             Text(
  //               "If you cancel now, your event will not be either published or saved. Are you sure you want to leave now?",
  //               style: TextStyle(height: 1.5,
  //                  wordSpacing: 2.0, fontWeight: FontWeight.w500, fontSize: 14,color: Colors.grey[600]),
  //             ),
  //
  //             SizedBox(height: 30),
  //
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: <Widget>[
  //                 Container(
  //                   height: 40,
  //                   width: 110,
  //                   child: MaterialButton(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                     ),
  //                     child: Text( "Yes",
  //                       style: TextStyle( color: Colors.blueAccent, fontSize: 16,
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                       closeScreen();
  //
  //
  //                     },
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //
  //                 Container(
  //                   height: 40,
  //                   width: 110,
  //                   child: MaterialButton(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(5.0),
  //                     ),
  //                     child: Text( "No",
  //                       style: TextStyle( color: Colors.red, fontSize: 16,
  //                     ),
  //                     ),
  //                     onPressed: ()=>Navigator.pop(context),
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 10),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // closeScreen(){
  //   Navigator.of(context).pop();
  // }


}
