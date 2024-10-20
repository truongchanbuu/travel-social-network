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
  String? _content;

  @override
  void initState() {
    super.initState();

    _commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentActionSucceed) {
          _commentController.clear();
          setState(() {
            _content = _commentController.text;
          });
          context.read<CommentBloc>().add(GetPostCommentsEvent(widget.postId));
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (value) => _onComment(context),
              controller: _commentController,
              maxLines: null,
              onChanged: (value) => setState(() => _content = value),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
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
            onPressed: _content?.isNotEmpty ?? false
                ? () => _onComment(context)
                : null,
            icon: Icon(
              Icons.send,
              color: _content?.isNotEmpty ?? false ? primaryColor : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  void _onComment(BuildContext context) {
    context.read<CommentBloc>().add(CreateCommentEvent(
          userId: userId,
          content: _content!,
          postId: widget.postId,
        ));
  }
}
