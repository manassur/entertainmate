import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';

import 'user_comment_event.dart';
import 'user_comment_state.dart';


class UserCommentBloc extends Bloc<UserCommentEvent, UserCommentState>{
  Repository userCommentRepository;

  UserCommentBloc({ @required this.userCommentRepository}) : super(null);


  @override
  UserCommentState get initialState => UserCommentInitialState();

  @override
  Stream<UserCommentState> mapEventToState(UserCommentEvent event) async* {
    if (event is FetchUserCommentEvent) {
      yield UserCommentLoadingState();
      try{
        UserCommentModel  userComment = await userCommentRepository.fetchUserComments(event.postId);
        if(userComment.comments.isNotEmpty) {
          yield UserCommentLoadedState(userComment: userComment, message: "user comment Updated");
        } else{
          yield UserCommentEmptyState(message: "this user has no comments");
        }
        }catch(e){
        yield UserCommentFailureState(error: e.toString());
      }
    }

  }

}