import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'comment_input.dart';
import 'comment_item.dart';

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Text(
            S.current.comment,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _buildComments(),
        const CommentInput(),
      ],
    );
  }

  static final List<int> samples = List.generate(100, (index) => index);
  Widget _buildComments() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => const CommentItem(),
        itemCount: samples.length,
      ),
    );
  }
}
