import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';

class CommentFooter extends StatefulWidget {
  final CommentEntity comment;
  final String userId;
  const CommentFooter({super.key, required this.comment, required this.userId});

  @override
  State<CommentFooter> createState() => _CommentFooterState();
}

class _CommentFooterState extends State<CommentFooter> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.comment.likedUsers.contains(widget.userId);
  }

  static const TextStyle actionTextStyle =
      TextStyle(color: Colors.grey, fontSize: 13);
  static const actionSpacing = SizedBox(width: 10);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _onLike,
          child: Text(
            S.current.like,
            style: actionTextStyle.copyWith(
              color: _isLiked ? primaryColor : null,
            ),
          ),
        ),
        actionSpacing,
        GestureDetector(
          onTap: _onReply,
          child: Text(S.current.reply, style: actionTextStyle),
        ),
        const SizedBox(width: 2),
        const Text(' · ', style: actionTextStyle),
        Text(
          DateTimeUtils.getTimeAgo(widget.comment.createdAt),
          style: actionTextStyle,
        ),
      ],
    );
  }

  void _onLike() {
    List<String> likedUsers = widget.comment.likedUsers;
    setState(() {
      _isLiked = !_isLiked;

      if (_isLiked) {
        likedUsers.add(widget.userId);
      } else {
        likedUsers.remove(widget.userId);
      }
    });

    context.read<CommentBloc>().add(UpdateCommentEvent(widget.comment.commentId,
        {CommentEntity.likedUsersFieldName: likedUsers}));
  }

  void _onReply() {
    context.read<CommentBloc>().add(InitializeReplyEvent(
          parentCommentId:
              widget.comment.parentCommentId ?? widget.comment.commentId,
          postId: widget.comment.postId,
          userId: widget.userId,
          commentOwner: widget.comment.userId,
        ));
  }
}
