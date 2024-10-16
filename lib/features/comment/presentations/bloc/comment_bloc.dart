import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_social_network/cores/resources/data_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/comment.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<CreateCommentEvent>(_onCreateComment);
    on<GetPostCommentsEvent>(_onGetPostComments);
  }

  Future<void> _onCreateComment(
      CreateCommentEvent event, Emitter<CommentState> emit) async {
    try {
      Comment comment = Comment(
        commentId: 'CMT-${const Uuid().v4()}',
        content: event.content,
        userId: event.userId,
        createdAt: DateTime.now(),
        likedUsers: const [],
        postId: event.postId,
      );

      final dataState = await commentRepository.createComment(comment);

      if (dataState is DataFailure) {
        log('Create Comment Failed: ${dataState.error?.message ?? dataState.error}');
        emit(CommentActionFailed(S.current.dataStateFailure));
      } else {
        emit(CommentActionSucceed(dataState.data!));
      }
    } catch (error) {
      log('Create Comment Failed: $error');
      emit(CommentActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onGetPostComments(
      GetPostCommentsEvent event, Emitter<CommentState> emit) async {
    try {
      final dataState = await commentRepository.getPostComments(event.postId);

      if (dataState is DataFailure) {
        log('Create Comment Failed: ${dataState.error?.message ?? dataState.error}');
        emit(CommentActionFailed(S.current.dataStateFailure));
      } else {
        emit(ListOfCommentsReceived(
          dataState.data?.map((comment) => comment.toEntity()).toList() ?? [],
        ));
      }
    } catch (error) {
      log('Get Comments Failed: $error');
      emit(CommentActionFailed(S.current.dataStateFailure));
    }
  }
}
