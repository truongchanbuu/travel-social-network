import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/custom_popup_menu.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
import '../../../user/presentations/widgets/user_avatar.dart';
import '../../domain/entities/post.dart';

class PostHeader extends StatefulWidget {
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
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  UserEntity? _cachedUser;

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);
    return BlocSelector<UserCubit, UserState, UserEntity>(
      selector: (state) {
        if (state.user.id == widget.post.userId) {
          _cachedUser = state.user;
          return state.user;
        }

        return _cachedUser ?? UserEntity.empty;
      },
      builder: (context, user) {
        final userToDisplay = _cachedUser ?? user;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: UserAvatar(user: userToDisplay),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        userToDisplay.username ??
                            userToDisplay.email ??
                            'Unknown',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textDirection: defaultTextDirection,
                        overflow: defaultTextOverflow,
                      ),
                    ),
                    Text(
                      DateTimeUtils.getTimeAgo(widget.post.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (widget.isMoreActionShowed)
              CustomPopupMenu(
                hasPrivilege: currentUser.id == widget.post.userId,
                onDelete: widget.onDelete,
                onEdit: widget.onEdit,
              ),
          ],
        );
      },
    );
  }
}
