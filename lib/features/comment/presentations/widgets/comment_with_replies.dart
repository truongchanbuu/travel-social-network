import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';
import 'comment_input.dart';
import 'comment_item.dart';
import 'reply_input.dart';

class CommentWithReplies extends StatefulWidget {
  final CommentEntity parentComment;
  const CommentWithReplies({super.key, required this.parentComment});

  @override
  State<CommentWithReplies> createState() => _CommentWithRepliesState();
}

class _CommentWithRepliesState extends State<CommentWithReplies> {
  bool _isRepliesShowed = false;
  List<CommentEntity> _cachedReplies = [];

  @override
  void initState() {
    super.initState();
    _loadReplies();
  }

  void _loadReplies() {
    context
        .read<CommentBloc>()
        .add(GetRepliesEvent(widget.parentComment.commentId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      buildWhen: (previous, current) {
        if (current is ReplyInitialized) {
          return current.comment.parentCommentId ==
              widget.parentComment.commentId;
        }

        if (current is ListOfRepliesReceived) {
          return current.replies.isNotEmpty &&
              current.replies.first.parentCommentId ==
                  widget.parentComment.commentId;
        }

        return current is CommentActionLoading;
      },
      builder: (context, state) {
        if (state is ListOfRepliesReceived) {
          _cachedReplies = state.replies;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommentItem(comment: widget.parentComment),
            if (_cachedReplies.isNotEmpty) ...[
              if (_isRepliesShowed)
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    children: _cachedReplies.map(_buildReplyItem).toList(),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: _buildExpandButton(),
              ),
            ],
            if (state is ReplyInitialized)
              Padding(
                  padding: const EdgeInsets.only(left: 65, right: 20),
                  child: _buildReplyInput(state.comment)),
          ],
        );
      },
    );
  }

  Widget _buildReplyItem(CommentEntity comment) {
    return CommentItem(comment: comment);
  }

  Widget _buildExpandButton() {
    return GestureDetector(
      onTap: () => setState(() => _isRepliesShowed = !_isRepliesShowed),
      child: Text(
        _isRepliesShowed ? S.current.showLess : S.current.showMore,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          decorationStyle: TextDecorationStyle.solid,
          decorationColor: Colors.grey,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildReplyInput(CommentEntity comment) {
    return ReplyInput(comment: comment);
  }
}
