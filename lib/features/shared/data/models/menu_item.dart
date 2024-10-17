import 'package:flutter/material.dart';

class MenuItem {
  final PopupMenuItemType itemType;
  final String title;
  final IconData icon;

  const MenuItem({
    required this.itemType,
    required this.title,
    required this.icon,
  });
}

enum PopupMenuItemType {
  edit,
  delete,
  chat,
}
