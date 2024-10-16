import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../domain/entities/post.dart';
import 'post_footer_actions.dart';

class PostItemFooter extends StatefulWidget {
  final PostEntity post;
  const PostItemFooter({super.key, required this.post});

  @override
  State<PostItemFooter> createState() => _PostItemFooterState();
}

class _PostItemFooterState extends State<PostItemFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('300k'),
              Row(
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
        PostFooterActions(post: widget.post)
      ],
    );
  }
}
