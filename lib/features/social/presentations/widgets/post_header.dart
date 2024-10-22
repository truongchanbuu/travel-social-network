import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../shared/presentations/widgets/custom_popup_menu.dart';
import '../../domain/entities/post.dart';

class PostHeader extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final bool isMoreActionShowed;

  const PostHeader({
    super.key,
    required this.post,
    this.onDelete,
    this.onEdit,
    this.isMoreActionShowed = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'TRUONG CHAN BUU',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textDirection: defaultTextDirection,
                    overflow: defaultTextOverflow,
                  ),
                ),
                Text(
                  DateTimeUtils.getTimeAgo(post.createdAt),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (isMoreActionShowed)
          CustomPopupMenu(
            hasPrivilege: currentUserId == post.userId,
            onDelete: onDelete,
            onEdit: onEdit,
          ),
      ],
    );
  }
}
