import 'package:flutter/material.dart';

class AccountDetailSection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  const AccountDetailSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Column(
          children: items,
        )
      ],
    );
  }
}
