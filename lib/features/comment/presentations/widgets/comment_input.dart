import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextFormField(
            maxLines: null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(5),
              hintText:
                  '${S.current.comment} ${S.current.here.toLowerCase()}...',
              hintMaxLines: 1,
              hintStyle: const TextStyle(overflow: defaultTextOverflow),
            ),
            textInputAction: TextInputAction.send,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.send,
            color: primaryColor,
          ),
        )
      ],
    );
  }
}
