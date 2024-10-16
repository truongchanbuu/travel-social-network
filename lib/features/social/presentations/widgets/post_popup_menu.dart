import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../data/models/post_menu_item.dart';
import '../bloc/post_bloc.dart';

class PostPopupMenu extends StatelessWidget {
  final String postId;
  const PostPopupMenu({super.key, required this.postId});

  static final List<PostMenuItem> menuItems = [
    PostMenuItem(
      itemType: PostMenuItemType.edit,
      title: S.current.edit,
      icon: Icons.edit,
    ),
    PostMenuItem(
      itemType: PostMenuItemType.delete,
      title: S.current.delete,
      icon: Icons.delete,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      menuPadding: EdgeInsets.zero,
      icon: const Icon(Icons.more_horiz, color: Colors.grey),
      itemBuilder: (context) =>
          menuItems.map((item) => _buildMenuItem(context, item)).toList(),
      tooltip: S.current.moreAction,
    );
  }

  static const Color menuItemColor = Colors.black54;
  PopupMenuItem _buildMenuItem(BuildContext context, PostMenuItem item) {
    return PopupMenuItem(
      onTap: () => _menuItemAction(context, item.itemType),
      value: item.itemType,
      child: ListTile(
        leading: Icon(item.icon, color: menuItemColor),
        title: Text(
          item.title,
          style: const TextStyle(color: menuItemColor),
        ),
      ),
    );
  }

  void _menuItemAction(BuildContext context, PostMenuItemType type) {
    switch (type) {
      case PostMenuItemType.delete:
        _deletePost(context);
        break;
      case PostMenuItemType.edit:
        // TODO: EDIT
        break;
    }
  }

  void _deletePost(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var confirmed = await confirmDeletion(context);

    if (confirmed) {
      postBloc.add(DeletePostById(postId));
    }
  }
}
