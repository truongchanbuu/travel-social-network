import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';

class CommentInput extends StatefulWidget {
  final String postId;
  const CommentInput({super.key, required this.postId});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late final TextEditingController _commentController;
  late final FocusNode _focusNode;
  String? _content;

  @override
  void initState() {
    super.initState();

    _commentController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc authBloc) => authBloc.state.user);
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentActionSucceed) {
          _commentController.clear();
          setState(() {
            _content = _commentController.text;
          });
          context.read<CommentBloc>().add(GetPostCommentsEvent(widget.postId));
        } else if (state is CommentUpdating) {
          _commentController.text = state.comment.content;
          _commentController.selection = TextSelection.fromPosition(
            TextPosition(offset: _commentController.text.length),
          );
          setState(() {
            _content = state.comment.content;
          });
          _focusNode.requestFocus();
        }
      },
      builder: (context, state) {
        if (state is ReplyInitialized) {
          return const SizedBox.shrink();
        }

        return _buildBody(state, user.id);
      },
    );
  }

  Widget _buildBody(CommentState state, String userId) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextFormField(
            focusNode: _focusNode,
            onFieldSubmitted: (value) => _onComment(context, userId),
            controller: _commentController,
            maxLines: null,
            onChanged: (value) => setState(() => _content = value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10),
              hintText:
                  '${S.current.commentLabel} ${S.current.here.toLowerCase()}...',
              hintMaxLines: 1,
              hintStyle: const TextStyle(overflow: defaultTextOverflow),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            textInputAction: TextInputAction.send,
          ),
        ),
        IconButton(
          onPressed: _content?.isNotEmpty ?? false
              ? () => _onComment(context, userId)
              : null,
          icon: Icon(
            Icons.send,
            color: _content?.isNotEmpty ?? false ? primaryColor : Colors.grey,
          ),
        )
      ],
    );
  }

  void _onComment(BuildContext context, String userId) {
    final commentBloc = context.read<CommentBloc>();
    final state = commentBloc.state;

    if (state is! CommentUpdating) {
      commentBloc.add(CreateCommentEvent(
        userId: userId,
        content: _content!,
        postId: widget.postId,
      ));
    } else {
      commentBloc.add(UpdateCommentEvent(state.comment.commentId, {
        CommentEntity.contentFieldName: _content,
        CommentEntity.updatedAtFieldName: DateTime.now().toIso8601String(),
      }));
    }
  }
}
