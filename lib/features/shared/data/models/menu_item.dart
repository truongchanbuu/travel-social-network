import 'package:flutter/material.dart';

class MenuItem {
  final PopupMenuItemType itemType;
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const MenuItem({
    required this.itemType,
    required this.title,
    required this.icon,
    this.onTap,
  });
}

enum PopupMenuItemType {
  edit,
  delete,
  chat,
}
