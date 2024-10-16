import 'package:flutter/material.dart';

class PostMenuItem {
  final PostMenuItemType itemType;
  final String title;
  final IconData icon;

  const PostMenuItem({
    required this.itemType,
    required this.title,
    required this.icon,
  });
}

enum PostMenuItemType {
  edit,
  delete,
}
