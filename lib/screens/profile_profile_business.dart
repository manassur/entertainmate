import 'package:entertainmate/bloc/register_business/register_business_bloc.dart';
import 'package:entertainmate/bloc/user_business/user_business_bloc.dart';
import 'package:entertainmate/screens/register_business_screen.dart';
import 'package:entertainmate/screens/utility/constants.dart';
import 'package:entertainmate/widgets/business_verified_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../invite.dart';
import 'events_item.dart';
import 'repository/repository.dart';
import 'utility/complete_profile_provider.dart';
import 'utility/constants.dart' as Constants;

class BusinessProfileScreen extends StatefulWidget {

  @override
  _BusinessProfileScreenState createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
          return   DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar:AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: TabBar(
                  unselectedLabelColor: Colors.grey[700],
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.blue,
                  labelPadding: EdgeInsets.all(0),
                  tabs: [
                    Tab(
                      text: "Verified",
                    ),
                    Tab(
                      text: "Registered",
                    ),
                    Tab(
                      text: "Incomplete",
                    ),


                  ],
                ),
              ),
              body: TabBarView(children: <Widget>[

                //MEDIA TAB
                // Container(
                //   child: Text("Verified Screen"),
                // ),

                BlocProvider<UserBusinessBloc>(create: (context)=> UserBusinessBloc(repository: Repository()),
                child: BusinessVerifiedWidget()),


                //MEDIA TAB
                Container(
                  child: Text("Registered Screen"),
                ),

                //EXPENSES TAB
                Container(
                  child: Text("Incomplete Screen"),
                ),


              ]),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black.withOpacity(0.7),
                child: Icon(Icons.add),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,

                    builder: (context) {
                      return  FractionallySizedBox(
                        heightFactor: 0.9,
                        child: BlocProvider<RegisterBusinessBloc>(
                            create: (context) => RegisterBusinessBloc(repository: Repository()),
                            child:RegisterBusinessScreen()

                        ),
                      );
                    },
                  );

                },
              ),

            ),

          );
        });

  }
}

