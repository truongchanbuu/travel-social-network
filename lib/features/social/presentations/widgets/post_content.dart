import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/limit_image_gridview.dart';
import '../../domain/entities/post.dart';

class PostContent extends StatelessWidget {
  final PostEntity post;

  const PostContent({
    super.key,
    required this.post,
  });

  static const TextStyle expandTextStyle = TextStyle(color: primaryColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (post.content.isNotEmpty) Flexible(child: _buildTextContent()),
        if (post.images.isNotEmpty) Flexible(child: _buildImagesWidget(context))
      ],
    );
  }

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
