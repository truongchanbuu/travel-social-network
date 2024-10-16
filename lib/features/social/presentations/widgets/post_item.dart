import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/limit_image_gridview.dart';
import '../../domain/entities/post.dart';
import 'post_item_footer.dart';
import 'post_popup_menu.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;
  const PostItem({super.key, required this.post});

  static const userId = 'TCB';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(),
        _buildContent(context),
        PostItemFooter(post: post),
      ],
    );
  }

  Widget _buildPostHeader() {
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
        if (userId == post.userId) PostPopupMenu(postId: post.postId),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (post.content.isNotEmpty) Flexible(child: _buildTextContent()),
        if (post.images.isNotEmpty) Flexible(child: _buildImagesWidget(context))
      ],
    );
  }

  static const TextStyle expandTextStyle = TextStyle(color: primaryColor);
  Widget _buildTextContent() => Padding(
        padding: const EdgeInsets.only(left: 15, right: 10, top: 5),
        child: ReadMoreText(
          post.content,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimExpandedText: S.current.showLess,
          trimCollapsedText: S.current.showMore,
          textDirection: defaultTextDirection,
          moreStyle: expandTextStyle,
          lessStyle: expandTextStyle,
        ),
      );

  Widget _buildImagesWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: LimitImageGridView(images: post.images),
    );
  }
}
