import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/limit_image_gridview.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import 'share_post_widget.dart';

class PostContent extends StatefulWidget {
  final PostEntity post;

  const PostContent({super.key, required this.post});

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  @override
  void initState() {
    super.initState();
    if (widget.post.refPostId != null) {
      context.read<PostBloc>().add(GetPostByIdEvent(widget.post.refPostId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.post.content.isNotEmpty)
          Flexible(child: _buildTextContent(context)),
        if (widget.post.images.isNotEmpty)
          Flexible(child: _buildImagesWidget(context)),
        if (widget.post.refPostId != null)
          Flexible(child: _buildRefPost(context)),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final TextStyle expandTextStyle = TextStyle(
        color: context.isDarkMode
            ? AppTheme.secondaryColorDark
            : AppTheme.primaryColor);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10, top: 5),
      child: ReadMoreText(
        widget.post.content,
        trimLines: 3,
        trimMode: TrimMode.Line,
        trimExpandedText: S.current.showLess,
        trimCollapsedText: S.current.showMore,
        textDirection: defaultTextDirection,
        moreStyle: expandTextStyle,
        lessStyle: expandTextStyle,
      ),
    );
  }

  Widget _buildImagesWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: LimitImageGridView(images: widget.post.images),
    );
  }

  Widget _buildRefPost(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      buildWhen: (previous, current) =>
          current is PostReceived &&
          current.post.postId == widget.post.refPostId &&
          current.post.sharedBy.contains(widget.post.postId),
      builder: (context, state) {
        if (state is PostReceived &&
            state.post.postId == widget.post.refPostId) {
          return SharePostWidget(post: widget.post);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
