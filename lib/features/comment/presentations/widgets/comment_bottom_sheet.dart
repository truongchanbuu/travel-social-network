import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';
import 'comment_input.dart';
import 'comment_with_replies.dart';

class CommentBottomSheet extends StatefulWidget {
  final String postId;
  const CommentBottomSheet({super.key, required this.postId});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  List<CommentEntity> cachedComments = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Text(
                  S.current.comment,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              BlocConsumer<CommentBloc, CommentState>(
                listener: (context, state) {
                  if (state is CommentDeleted) {
                    cachedComments.removeWhere(
                        (cmt) => cmt.commentId == state.comment.commentId);
                    context
                        .read<CommentBloc>()
                        .add(GetPostCommentsEvent(widget.postId));
                  }
                },
                builder: (context, state) {
                  if (state is CommentActionLoading ||
                      state is CommentInitial) {
                    return const AppProgressingIndicator();
                  }

                  if (state is ListOfCommentsReceived) {
                    if (!const DeepCollectionEquality()
                        .equals(cachedComments, state.comments)) {
                      cachedComments = state.comments;
                    }
                  }

                  return _buildComments(cachedComments);
                },
                buildWhen: (previous, current) =>
                    current is ListOfCommentsReceived &&
                    current.comments != cachedComments,
              ),
            ],
          ),
        ),
        CommentInput(postId: widget.postId),
      ],
    );
  }

  Widget _buildComments(List<CommentEntity> comments) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => CommentWithReplies(
          key: ValueKey(comments[index].commentId),
          parentComment: comments[index],
        ),
        itemCount: comments.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
