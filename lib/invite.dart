import 'package:entertainmate/phone_invite.dart';
import 'package:entertainmate/screens/email_invite.dart';
// import 'file:///C:/Users/Olugunde/Documents/FlutterApps/entertainmate/lib/screens/verify_phone/phone_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/utility/complete_profile_provider.dart';

class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
    CompleteProfileProvider _detailsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);

  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child:Consumer<CompleteProfileProvider>(
        builder: (context, data, child)
    {return Scaffold(
          appBar: AppBar(
            leading: IconButton(color:Colors.grey,icon:Icon( Icons.arrow_back_ios),onPressed: (){Navigator.of(context).pop();},),
              title: Text("Invite Friends",style: TextStyle(color: Colors.black),),
              centerTitle: true,
              actions: [Center(child: Padding(
                padding: const EdgeInsets.only(right:15.0),
                child: Text((5-data.user.invites).toString()+" Invites left",style: TextStyle(color:Colors.blue,fontSize: 16,fontWeight: FontWeight.w500),),
              ))],
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: new PreferredSize(
              preferredSize: new Size(0.0, 50.0),
              child: Container(
                decoration:BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: TabBar(

                    unselectedLabelColor: Colors.black87,
                    labelColor: Colors.black87,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white, Colors.white]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Phone Number"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Email address"),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          body:Container(
            margin: EdgeInsets.only(top:20),
            child: TabBarView(children: [
              Phone_Invite(),
              EmailInvite(),
            ]),
          ),
        );
    }));

  }
}
