import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: '${S.current.comment} ${S.current.here.toLowerCase()}...',
            hintMaxLines: 1,
            hintStyle: const TextStyle(overflow: defaultTextOverflow),
          ),
          textInputAction: TextInputAction.send,
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
              color: primaryColor,
            ))
      ],
    );
  }
}
