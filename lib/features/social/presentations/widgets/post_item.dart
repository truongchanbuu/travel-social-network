import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:readmore/readmore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../../shared/presentations/widgets/custom_popup_menu.dart';
import '../../../shared/presentations/widgets/limit_image_gridview.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../pages/post_upload_page.dart';
import 'post_footer.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;
  const PostItem({super.key, required this.post});

  static const TextStyle expandTextStyle = TextStyle(color: primaryColor);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(context, state),
            _buildContent(context, state),
            PostFooter(post: _getPost(state)),
          ],
        );
      },
      buildWhen: (previous, current) => current is PostReceived,
    );
  }

  Widget _buildPostHeader(BuildContext context, PostState state) {
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
                  DateTimeUtils.getTimeAgo(_getPost(state).createdAt),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        CustomPopupMenu(
          hasPrivilege: currentUserId == post.userId,
          onDelete: () => _deletePost(context),
          onEdit: () => _editPost(context),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, PostState state) {
    final post = _getPost(state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (post.content.isNotEmpty) Flexible(child: _buildTextContent(post)),
        if (post.images.isNotEmpty)
          Flexible(child: _buildImagesWidget(context, post.images))
      ],
    );
  }

  Widget _buildTextContent(PostEntity post) => Padding(
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

  Widget _buildImagesWidget(BuildContext context, List<String> images) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: LimitImageGridView(images: images),
    );
  }

  void _deletePost(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var confirmed = await confirmDeletion(
      context,
      confirmTitle: S.current.deleteConfirmTitle,
      confirmMessage: S.current.deleteConfirmText,
    );

    if (confirmed) {
      postBloc.add(DeletePostById(post.postId));
    }
  }

  void _editPost(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var data = await Navigator.push(
      context,
      PageTransition(
        child: BlocProvider(
          create: (context) =>
              getIt.get<PostBloc>()..add(GetPostByIdEvent(post.postId)),
          child: const PostUploadPage(),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );

    if (data != null && data is PostEntity && data != post) {
      postBloc.add(GetPostByIdEvent(data.postId));
    }
  }

  PostEntity _getPost(PostState state) {
    return state is PostReceived && state.post.postId == post.postId
        ? state.post
        : post;
  }
}
