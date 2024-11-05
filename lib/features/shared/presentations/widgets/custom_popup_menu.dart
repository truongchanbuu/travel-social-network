import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/menu_item.dart';

class CustomPopupMenu extends StatelessWidget {
  final EdgeInsets? padding;
  final double? iconSize;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onChat;
  final bool hasPrivilege;
  final List<PopupMenuItemType> types;

  const CustomPopupMenu({
    super.key,
    this.hasPrivilege = false,
    this.onDelete,
    this.onEdit,
    this.onChat,
    this.iconSize,
    this.padding,
    this.types = const <PopupMenuItemType>[],
  });

  List<MenuItem> _buildMenuItems() {
    final baseItems = [
      if (hasPrivilege) ...[
        MenuItem(
          itemType: PopupMenuItemType.edit,
          title: S.current.edit,
          icon: Icons.edit,
          onTap: onEdit,
        ),
        MenuItem(
          itemType: PopupMenuItemType.delete,
          title: S.current.delete,
          icon: Icons.delete,
          onTap: onDelete,
        ),
      ],
      MenuItem(
        itemType: PopupMenuItemType.chat,
        title: S.current.chat,
        icon: Icons.chat,
        onTap: onChat,
      ),
    ];

    return types.isEmpty
        ? baseItems
        : baseItems.where((item) => types.contains(item.itemType)).toList();
  }

  PopupMenuItem _buildMenuItem(MenuItem item) {
    return PopupMenuItem(
      onTap: item.onTap,
      value: item.itemType,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(item.icon, size: 20),
        title: Text(item.title),
        dense: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = _buildMenuItems();

    return PopupMenuButton(
      menuPadding: EdgeInsets.zero,
      itemBuilder: (_) => menuItems.map(_buildMenuItem).toList(),
      tooltip: S.current.moreAction,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.more_horiz,
          color: Colors.grey,
          size: iconSize,
        ),
      ),
    );
  }
}
