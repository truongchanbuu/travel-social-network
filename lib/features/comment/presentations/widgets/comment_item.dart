import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/data/models/menu_item.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../../shared/presentations/widgets/custom_popup_menu.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
import '../../../user/presentations/widgets/user_avatar.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';
import 'comment_footer.dart';

class CommentItem extends StatefulWidget {
  final CommentEntity comment;
  const CommentItem({super.key, required this.comment});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  UserEntity? _cachedUser;

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);
    return BlocSelector<UserCubit, UserState, UserEntity>(
      selector: (state) {
        if (state.user.id == widget.comment.userId) {
          _cachedUser = state.user;
          return state.user;
        }

        return _cachedUser ?? UserEntity.empty;
      },
      builder: (context, user) {
        final userToDisplay = _cachedUser ?? user;

        return Stack(
          children: [
            ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              leading: UserAvatar(user: userToDisplay),
              title: _buildCommentBody(currentUser.id),
              subtitle: _buildCommentFooter(context, currentUser.id),
            ),
            if (_isSomebodyLiked)
              Positioned(right: 30, bottom: 25, child: _buildReactions()),
          ],
        );
      },
    );
  }

  Widget _buildCommentBody(String userId) {
    return Container(
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
      padding: EdgeInsets.only(
          left: 10, right: 5, top: 5, bottom: _isSomebodyLiked ? 15 : 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // TODO: CHANGE TO USERNAME
                widget.comment.userId,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              CustomPopupMenu(
                iconSize: 20,
                padding: EdgeInsets.zero,
                hasPrivilege: userId == widget.comment.userId,
                types: const [PopupMenuItemType.edit, PopupMenuItemType.delete],
                onDelete: () => _onDeleteComment(context),
                onEdit: () => _onEditComment(context),
              )
            ],
          ),
          ReadMoreText(
            widget.comment.content,
            style: const TextStyle(fontSize: 14),
            trimCollapsedText: ' ${S.current.showMore}',
            trimExpandedText: ' ${S.current.showLess}',
            moreStyle: const TextStyle(color: primaryColor),
            lessStyle: const TextStyle(color: primaryColor),
            trimLines: 2,
            trimMode: TrimMode.Line,
          )
        ],
      ),
    );
  }

  Widget _buildCommentFooter(BuildContext context, String userId) => Padding(
        padding: const EdgeInsets.only(top: 5, left: 10),
        child: CommentFooter(comment: widget.comment, userId: userId),
      );

  Widget _buildReactions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black12,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.thumb_up,
            color: primaryColor,
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            widget.comment.likedUsers.length.toString(),
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  void _onDeleteComment(BuildContext context) async {
    final commentBloc = context.read<CommentBloc>();
    bool confirmed = await confirmDeletion(
      context,
      confirmTitle: S.current.deleteConfirmTitle,
      confirmMessage: S.current.deleteConfirmText,
    );

    if (confirmed) {
      commentBloc.add(DeleteCommentEvent(widget.comment.commentId));
    }
  }

  void _onEditComment(BuildContext context) {
    context.read<CommentBloc>().add(UpdatingCommentEvent(widget.comment));
  }

  bool get _isSomebodyLiked => widget.comment.likedUsers.isNotEmpty;
}
