import 'package:flutter/material.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:provider/provider.dart';

class CompleteBio extends StatefulWidget {
  @override
  _CompleteBioState createState() => _CompleteBioState();
}

class _CompleteBioState extends State<CompleteBio> {
  CompleteProfileProvider _detailsProvider;


  @override
  void initState() {
    super.initState ( );
    _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<CompleteProfileProvider>(
        builder: (context, data, child) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(child: Text('Please tell more about yourself so that friends and community can know who you are!',textAlign: TextAlign.center, style:TextStyle(fontSize: 15.0) ,)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin:EdgeInsets.only(left:10,right:10),
              child: Row(
                children: [

                  Expanded(child: TextField(
                    maxLines: 8,
                    minLines: 8,
                    onChanged:(value) {
                        data.setBio(value);

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),

                  ))
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkResponse(
                    onTap: (){
                    data.setCurrentPage(2);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: data
                                .bio.isNotEmpty ? Colors
                                .blue : Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 8.0,
                              )
                            ]
                        ),
                        child: Center ( child: Text ( 'Next',
                          style: TextStyle ( fontSize: 15.0,
                              color: data
                                  .bio.isNotEmpty
                                  ? Colors.white
                                  : Colors.blue ), ) ),
                      ),
                    ),
                  ),
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
