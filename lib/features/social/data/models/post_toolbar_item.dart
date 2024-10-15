import 'package:flutter/material.dart';

class PostToolbarItem {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const PostToolbarItem({
    required this.text,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });
}
