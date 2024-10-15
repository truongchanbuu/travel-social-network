import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/post_toolbar_item.dart';

class PostToolbarBottomSheet extends StatelessWidget {
  const PostToolbarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items.map(_buildItem).toList(),
    );
  }

  Widget _buildItem(PostToolbarItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: item.iconColor,
        ),
        title: Text(item.text),
      ),
    );
  }
}
