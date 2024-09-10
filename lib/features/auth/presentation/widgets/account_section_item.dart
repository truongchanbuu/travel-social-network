import 'package:flutter/material.dart';

class AccountSectionItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget value;
  const AccountSectionItem({
    super.key,
    required this.title,
    required this.value,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        onTap: () {},
        leading: leading,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title),
            value,
          ],
        ),
      ),
    );
  }
}
