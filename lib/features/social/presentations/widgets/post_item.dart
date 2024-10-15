import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/post.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(),
        _buildContent(),
      ],
    );
  }

  Widget _buildPostHeader() {
    return const ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      leading: CircleAvatar(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
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
            '1 hours ago',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle expandTextStyle = TextStyle(color: primaryColor);
  Widget _buildContent() {
    return Column(
      children: [
        _buildTextContent(),
        if (post.images.isNotEmpty) _buildImagesWidget()
      ],
    );
  }

  Widget _buildTextContent() => Padding(
        padding: const EdgeInsets.only(left: 15, right: 10, top: 7, bottom: 7),
        child: ReadMoreText(
          'tdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadastdsadas ',
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimExpandedText: S.current.showLess,
          trimCollapsedText: S.current.showMore,
          textDirection: defaultTextDirection,
          moreStyle: expandTextStyle,
          lessStyle: expandTextStyle,
        ),
      );

  Widget _buildImagesWidget() {
    return Container();
  }
}
