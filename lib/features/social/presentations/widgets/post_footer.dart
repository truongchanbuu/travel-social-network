import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
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
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('200k'),
                  SizedBox(width: 5),
                  Text('300k'),
                ],
              )
            ],
          ),
        ),
        PostFooterActions(post: post)
      ],
    );
  }
}
