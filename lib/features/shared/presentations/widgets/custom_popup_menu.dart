import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/menu_item.dart';

class CustomPopupMenu extends StatefulWidget {
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

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  List<MenuItem> menuItems = [];
  @override
  void initState() {
    super.initState();

    menuItems = [
      if (widget.hasPrivilege) ...[
        MenuItem(
          itemType: PopupMenuItemType.edit,
          title: S.current.edit,
          icon: Icons.edit,
        ),
        MenuItem(
          itemType: PopupMenuItemType.delete,
          title: S.current.delete,
          icon: Icons.delete,
        ),
      ],
      MenuItem(
        itemType: PopupMenuItemType.chat,
        title: S.current.chat,
        icon: Icons.chat,
      ),
    ];

    if (widget.types.isNotEmpty) {
      menuItems = menuItems
          .where((item) => widget.types.contains(item.itemType))
          .toList();
    }
  }

  static const Color menuItemColor = Colors.black54;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      menuPadding: EdgeInsets.zero,
      itemBuilder: (context) =>
          menuItems.map((item) => _buildMenuItem(context, item)).toList(),
      tooltip: S.current.moreAction,
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.more_horiz,
          color: Colors.grey,
          size: widget.iconSize,
        ),
      ),
    );
  }

  PopupMenuItem _buildMenuItem(BuildContext context, MenuItem item) {
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

  void _menuItemAction(BuildContext context, PopupMenuItemType type) {
    switch (type) {
      case PopupMenuItemType.delete:
        widget.onDelete?.call();
        break;
      case PopupMenuItemType.edit:
        widget.onEdit?.call();
        break;
      case PopupMenuItemType.chat:
      // TODO: Handle this case.
    }
  }
}
