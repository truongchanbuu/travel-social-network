import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';
import 'comment_item.dart';

class CommentWithReplies extends StatefulWidget {
  final CommentEntity parentComment;
  const CommentWithReplies({super.key, required this.parentComment});

  @override
  State<CommentWithReplies> createState() => _CommentWithRepliesState();
}

class _CommentWithRepliesState extends State<CommentWithReplies> {
  List<CommentEntity> cachedReplies = [];

  @override
  void initState() {
    super.initState();
    context
        .read<CommentBloc>()
        .add(GetRepliesEvent(widget.parentComment.commentId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is ListOfRepliesReceived) {
          cachedReplies = state.replies;
        }

        return Column(
          children: [
            CommentItem(comment: widget.parentComment),
            if (state is ListOfRepliesReceived)
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  children: state.replies.map(_buildReplyItem).toList(),
                ),
              )
          ],
        );
      },
    );
  }

  Widget _buildReplyItem(CommentEntity comment) {
    return CommentItem(comment: comment);
  }
}
