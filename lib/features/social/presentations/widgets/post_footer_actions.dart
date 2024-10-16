import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../comment/presentations/widgets/comment_bottom_sheet.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import 'post_footer_item.dart';

class PostFooterActions extends StatefulWidget {
  final PostEntity post;
  const PostFooterActions({super.key, required this.post});

  @override
  State<PostFooterActions> createState() => _PostFooterActionsState();
}

class _PostFooterActionsState extends State<PostFooterActions> {
  static const userId = 'TCB';
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();

    _isUserLiked();
  }

  void _isUserLiked() {
    _isLiked = widget.post.likedUsers.contains(userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostActionFailed) {
          showToast(state.message, context: context);
          setState(() {
            _isLiked = false;
          });
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PostFooterItem(
                icon: _isLiked
                    ? CommunityMaterialIcons.thumb_up
                    : CommunityMaterialIcons.thumb_up_outline,
                title: 'Like',
                onTap: _onLike,
                iconColor: _isLiked ? primaryColor : null,
              ),
            ),
            Expanded(
              child: PostFooterItem(
                icon: CommunityMaterialIcons.comment_outline,
                title: S.current.comment,
                onTap: _onComment,
              ),
            ),
            Expanded(
              child: PostFooterItem(
                icon: CommunityMaterialIcons.share_outline,
                title: S.current.share,
                onTap: _onShare,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLike() {
    List<String> likedUsers = widget.post.likedUsers;

    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        likedUsers.add(userId);
      } else {
        likedUsers.remove(userId);
      }
    });

    context.read<PostBloc>().add(LikePostEvent(
        widget.post.postId, {PostEntity.likedUsersFieldName: likedUsers}));
  }

  void _onComment() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      shape: bottomSheetShape,
      context: context,
      builder: (context) => const CommentBottomSheet(),
    );
  }

  void _onShare() {}
}
