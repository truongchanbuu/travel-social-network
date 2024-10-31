import 'package:flutter/material.dart';

class AccountSectionItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget value;
  final void Function()? onTap;

  const AccountSectionItem({
    super.key,
    required this.title,
    required this.value,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            value,
          ],
        ),
      ),
    );
  }
}
