import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../comment/domain/entities/comment.dart';
import '../../../comment/presentations/bloc/comment_bloc.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import 'post_footer_actions.dart';

class PostFooter extends StatelessWidget {
  final PostEntity post;
  const PostFooter({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final numCompactFormatter = NumberFormat.compact();
    PostEntity builtPost = post;

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
                  if (state is PostActionSucceed) {
                    builtPost = state.post;
                  }

                  return Row(
                    children: [
                      const Icon(Icons.thumb_up, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(numCompactFormatter
                          .format(builtPost.likedUsers.length)),
                    ],
                  );
                },
                buildWhen: (previous, current) {
                  return current is PostActionSucceed;
                },
              ),
              BlocBuilder<CommentBloc, CommentState>(
                buildWhen: (previous, current) {
                  return current is ListOfCommentsReceived &&
                      current.comments.isNotEmpty &&
                      current.comments.first.postId == post.postId;
                },
                builder: (context, state) {
                  int totalComments = 0;

                  if (state is ListOfCommentsReceived) {
                    totalComments = _getCurrentPostComment(state.comments);
                  }

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          '${numCompactFormatter.format(totalComments)} ${S.current.comment(totalComments)}'),
                      const SizedBox(width: 5),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          if (state is PostActionSucceed) {
                            builtPost = state.post;
                          }

                          return Text(
                              '${numCompactFormatter.format(builtPost.sharedBy.length)} ${S.current.share(builtPost.sharedBy.length)}');
                        },
                        buildWhen: (previous, current) {
                          return current is PostActionSucceed;
                        },
                      ),
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
