import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/comment.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<CreateCommentEvent>(_onCreateComment);
  }

  Future<void> _onCreateComment(
      CreateCommentEvent event, Emitter<CommentState> emit) async {
    try {} catch (error) {}
  }
}
