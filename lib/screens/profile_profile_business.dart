import 'package:entertainmate/bloc/post_comment/post_comment_bloc.dart';
import 'package:entertainmate/bloc/register_business/register_business_bloc.dart';
import 'package:entertainmate/bloc/user_business/user_business_bloc.dart';
import 'package:entertainmate/widgets/business_verified_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'register_business_screen.dart';
import 'repository/repository.dart';
import 'utility/complete_profile_provider.dart';

class BusinessProfileScreen extends StatefulWidget {
  @override
  _BusinessProfileScreenState createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CompleteProfileProvider>(builder: (context, data, child) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: SizedBox(
                        height: 50,
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          bottom: TabBar(
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
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                          height: 600,
                          //height of TabBarView SOEMTHING HAS TO BE DONE
                          //ABOUT THIS STATIC HEIGHT FOR THE TABBAR

                          child: TabBarView(children: <Widget>[
                            //VERIFIED TAB
                            BlocProvider<UserBusinessBloc>(
                                create: (context) =>
                                    UserBusinessBloc(repository: Repository()),
                                child: BlocProvider<PostCommentBloc>(
                                    create: (context) =>
                                        PostCommentBloc(postCommentRepository: Repository()),
                                    child: BusinessVerifiedWidget(status: 'verified',))),

                            //REGISTERED TAB
                            BlocProvider<UserBusinessBloc>(
                                create: (context) =>
                                    UserBusinessBloc(repository: Repository()),
                                child: BlocProvider<PostCommentBloc>(
                                    create: (context) =>
                                        PostCommentBloc(postCommentRepository: Repository()),
                                    child: BusinessVerifiedWidget(status: 'registered',))),

                            //INCOMPLETE TAB
                            BlocProvider<UserBusinessBloc>(
                                create: (context) =>
                                    UserBusinessBloc(repository: Repository()),
                                child: BlocProvider<PostCommentBloc>(
                                    create: (context) =>
                                        PostCommentBloc(postCommentRepository: Repository()),
                                    child: BusinessVerifiedWidget(status: 'incomplete',))),
                          ])),
                    )
                  ])),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black.withOpacity(0.7),
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 0.95,
                    child: BlocProvider<RegisterBusinessBloc>(
                        create: (context) =>
                            RegisterBusinessBloc(repository: Repository()),
                        child: RegisterBusinessScreen()),
                  );
                },
              );
            },
          ));
    });
  }
}
