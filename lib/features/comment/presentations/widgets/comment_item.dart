import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/comment.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black12,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: const CircleAvatar(radius: smallCircleAvatarRadius),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // TODO: CHANGE TO USERNAME
              comment.userId,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            ReadMoreText(
              comment.content,
              style: const TextStyle(
                fontSize: 14,
              ),
              trimCollapsedText: ' ${S.current.showMore}',
              trimExpandedText: ' ${S.current.showLess}',
              moreStyle: const TextStyle(color: primaryColor),
              lessStyle: const TextStyle(color: primaryColor),
              trimLines: 2,
              trimMode: TrimMode.Line,
            )
          ],
        ),
      ),
    );
  }
}
