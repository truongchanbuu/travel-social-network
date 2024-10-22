import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_social_network/features/comment/domain/entities/comment.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../comment/presentations/bloc/comment_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import 'post_footer_actions.dart';

class PostFooter extends StatelessWidget {
  final PostEntity post;
  const PostFooter({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      const Icon(Icons.thumb_up, color: primaryColor),
                      const SizedBox(width: 8),
                      Text(post.likedUsers.length.toString()),
                    ],
                  );
                },
                buildWhen: (previous, current) {
                  return current is PostActionSucceed && current.post != post;
                },
              ),
              BlocBuilder<CommentBloc, CommentState>(
                buildWhen: (previous, current) {
                  return current is ListOfCommentsReceived &&
                      current.comments.isNotEmpty &&
                      current.comments.first.postId == post.postId;
                },
                builder: (context, state) {
                  int total = 0;

                  if (state is ListOfCommentsReceived) {
                    total = _getCurrentPostComment(state.comments);
                  }

                  String commentTotalFormated =
                      NumberFormat.compact().format(total);

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$commentTotalFormated ${S.current.comment(total)}'),
                      const SizedBox(width: 5),
                      const Text('300k'),
                    ],
                  );
                },
              )
            ],
          ),
        ),
        PostFooterActions(post: post)
      ],
    );
  }

  int _getCurrentPostComment(List<CommentEntity> comments) {
    return comments.where((cmt) => cmt.postId == post.postId).length;
  }
}
