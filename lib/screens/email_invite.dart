import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'utility/complete_profile_provider.dart';

class EmailInvite extends StatefulWidget {
  @override
  _EmailInviteState createState() => _EmailInviteState();
}

class _EmailInviteState extends State<EmailInvite> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isLoading=false;

  CompleteProfileProvider _detailsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);

  }

  void sendInvite(email, name) async {
    setState(() {
      isLoading = true;
    });
    String username = 'entertainmateapp@gmail.com';
    String password = 'entertain_mate@123';
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(email, name)
      ..recipients.add(email)
      ..subject = 'Join me on Entertainmate :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the invite.\nwelcome to entertainmate.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's a great app you should try</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      setState(() {
        isLoading = false;
        _nameController.clear();
        _emailController.clear();
      });


    } on MailerException catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Message not sent.'+e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey[100],
                            height: 170,
                            width: 1,
                          ),
                          Expanded(
                            flex: 9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextField(
                                            controller: _nameController,
                                        onChanged: (value) {
                                            setState(() {

                                            });
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ))
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
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextField(
                                            controller: _emailController,
                                        onChanged: (value) {
                                          setState(() {

                                          });
//                      setState(() {
//                        smsOTP = value;
//                      });
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ))
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
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkResponse(
                        onTap: () {
                          if(_nameController.text.isNotEmpty && _emailController.text.isNotEmpty){
                            if(data.user.invites<5){
                              data.sendEmailInvite(_emailController.text);

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
                          }else{
                            // show an error to fill all fields , or don't bother since the button is not activated
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 15.0, 30.0, 15.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color:
                                _nameController.text.isEmpty || _emailController.text.isEmpty ? Colors.white : Colors.blue,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black54.withOpacity(0.2),
                                    blurRadius: 8.0,
                                  )
                                ]),
                            child: Center(
                                child:  data.emailInviteLoading==false? Text(
                              'Invite',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: _nameController.text.isEmpty || _emailController.text.isEmpty
                                      ? Colors.blue
                                      : Colors.white),
                            ):  SizedBox(height: 20,width: 20, child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),))

                          ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

        });
  }
}
