import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/welcome.dart';
import 'package:flutter/material.dart';

class Account_Settings extends StatefulWidget {
  @override
  _Account_SettingsState createState() => _Account_SettingsState();
}

class _Account_SettingsState extends State<Account_Settings> {
  Repository _userRepository;
  bool isUserLoggedIn = false;
  User user = User();

  @override
  void initState() {
    _userRepository = Repository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(color:Colors.grey,icon:Icon( Icons.arrow_back_ios),onPressed: (){Navigator.of(context).pop();},),
            title: Text("Account Settings",style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: [
              Center(child: Padding(
              padding: const EdgeInsets.only(right:15.0),
              child: InkResponse(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return FractionallySizedBox(
                            heightFactor: 0.40,
                            child:
                            Container(
                              padding: EdgeInsets.all(20.0),
                              color:Colors.white,
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text("Logging Out?",
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
                                  SizedBox(height: 25),

                                  Text("Sad to see you are leaving. You can log in back using the same number you're logged in with now.\n Are you sure you want to log out?",
                                    style: TextStyle( fontWeight: FontWeight.w300, fontSize: 18,
                                    ),
                                  ),

                                  SizedBox(height: 50),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 150,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            side: BorderSide(color: Colors.red[900])
                                          ),
                                          // borderSide: BorderSide(color: Colors.red),
                                          child: Text( "Log out", style: TextStyle( color: Colors.red[900], fontSize: 20,
                                          ),
                                          ),

                                          onPressed: (){
                                            _userRepository.logoutUser();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => Welcome(),
                                              ),
                                                  (route) => false,
                                            );
                                          },
                                        ),
                                      ),

                                      SizedBox(width: 10),

                                      Container(
                                        height: 50,
                                        width: 150,
                                        child: RaisedButton(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                          child: Text( "Stay in",
                                            style: TextStyle( color: Colors.white, fontSize: 20,
                                            ),
                                          ),
                                          onPressed: ()=>Navigator.pop(context),

                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),

                            )
                        );
                      },
                    );
                  },
                  child: Text("Log out",style: TextStyle(color:Colors.blue,fontSize: 18,fontWeight: FontWeight.w500),)),
            ))],
          ),
      body: Container(
        color: Colors.white12,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top:35.0),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.topCenter,
                  width: 100,
                  decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                  BoxShadow (
                  color: Colors.black54.withOpacity (
                      0.2 ),
                  blurRadius: 8.0,
                ),]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Events", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)),
                          Spacer(),
                          Icon(Icons.event_note_outlined,color: Colors.blue,),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Local deals", style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.w500)),
                          Spacer(),
                          Icon(Icons.attach_money,color: Colors.blue,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow (
                        color: Colors.black54.withOpacity (
                            0.2 ),
                        blurRadius: 8.0,
                      ),]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Updates", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Text("FAQ", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Text("Terms of use", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Text("Privacy policies", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        );
  }
}
