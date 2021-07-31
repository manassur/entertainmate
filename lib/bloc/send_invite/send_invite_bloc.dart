import 'dart:async';
import 'package:entertainmate/bloc/post_comment/post_comment_event.dart';
import 'package:entertainmate/bloc/post_comment/post_comment_state.dart';
import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  Repository postCommentRepository;

  PostCommentBloc({@required this.postCommentRepository}) : super(null);

  @override
  PostCommentState get initialState => PostCommentInitialState();

  @override
  Stream<PostCommentState> mapEventToState(PostCommentEvent event) async* {
    if (event is PostingCommentEvent) {
      yield PostCommentLoadingState();
      try {
        GenericResponse postCommentResponse = await postCommentRepository.postComment(event.comment, event.postId);
        if(postCommentResponse.error!=true){
          yield PostedCommentState(postId: postCommentResponse.message );
        }else{
          yield  PostCommentFailureState(message: postCommentResponse.message );
        }
      } catch (e) {
        yield PostCommentFailureState(message: e.toString());
      }
    }

  }
}
