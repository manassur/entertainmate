import 'package:flutter/material.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({Key key}) : super(key: key);

  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            margin: EdgeInsets.fromLTRB( 10.0, 20.0, 20.0, 15.0),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: TextField(
              autofocus: false,
              controller: searchController,
              onChanged: (String txt) {},
              style:  TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search here ',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400],),
                suffixIcon: InkWell(
                  onTap: (){
                    searchController.clear();
                  },
                    child: Icon(Icons.cancel, size: 20, color: Colors.grey[400],))
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: Text(
                    "Cancel", style: TextStyle(color: Colors.blue, fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: DefaultTabController(
        length: 4,
        child:  Scaffold(
          backgroundColor:Colors.grey[200],
          appBar:  PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child:  Container(
              margin: EdgeInsets.only(top: 1),
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration:BoxDecoration(
                        color:Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                      height: 40,
                      child: Center(
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
                                  child: Text("Events"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("People"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Offers"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Places"),
                                ),
                              ),
                            ]),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          body:  TabBarView(
            children: <Widget>[
               Container(color: Colors.transparent,),
               Container(color: Colors.red,),
               Container(color: Colors.blueAccent,),
               Container(color: Colors.deepOrange,),
            ]

          ),
        ),
      ),
    );
  }
}
