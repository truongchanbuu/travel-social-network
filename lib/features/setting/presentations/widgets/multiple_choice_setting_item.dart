import 'package:flutter/material.dart';

class MultipleChoiceSettingItem extends StatelessWidget {
  final String title;
  final String choice;
  const MultipleChoiceSettingItem({
    super.key,
    required this.title,
    required this.choice,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            choice,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
