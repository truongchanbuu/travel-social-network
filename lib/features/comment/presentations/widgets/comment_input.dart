import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../bloc/comment_bloc.dart';

class CommentInput extends StatefulWidget {
  final String postId;
  const CommentInput({super.key, required this.postId});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  static const String userId = 'TCB';
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();

    _commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextFormField(
            controller: _commentController,
            maxLines: null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(5),
              hintText:
                  '${S.current.comment} ${S.current.here.toLowerCase()}...',
              hintMaxLines: 1,
              hintStyle: const TextStyle(overflow: defaultTextOverflow),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            textInputAction: TextInputAction.send,
          ),
        ),
        IconButton(
          onPressed: () => _onComment(context),
          icon: const Icon(
            Icons.send,
            color: primaryColor,
          ),
        )
      ],
    );
  }

  void _onComment(BuildContext context) {
    context.read<CommentBloc>().add(CreateCommentEvent(
          userId: userId,
          content: _commentController.text,
          postId: widget.postId,
        ));
  }
}
