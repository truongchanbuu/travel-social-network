import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(radius: smallCircleAvatarRadius),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nguyen Van A',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          ReadMoreText(
            'Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao! Comment dao!',
            trimCollapsedText: ' ${S.current.showMore}',
            trimExpandedText: ' ${S.current.showLess}',
            moreStyle: const TextStyle(color: primaryColor),
            lessStyle: const TextStyle(color: primaryColor),
            trimLines: 3,
            trimMode: TrimMode.Line,
          )
        ],
      ),
    );
  }
}
