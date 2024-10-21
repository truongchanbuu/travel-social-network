import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/comment.dart';
import '../bloc/comment_bloc.dart';

class ReplyInput extends StatefulWidget {
  final CommentEntity comment;
  const ReplyInput({super.key, required this.comment});

  @override
  State<ReplyInput> createState() => _ReplyInputState();
}

class _ReplyInputState extends State<ReplyInput> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.comment.content);
    _formKey = GlobalKey();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        onFieldSubmitted: (value) =>
            _replyComment(widget.comment, content: value),
        onChanged: (value) => setState(() {
          _controller.text = value;
        }),
        maxLines: null,
        textDirection: defaultTextDirection,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black12, width: 0.5),
          ),
          suffixIcon: GestureDetector(
            onTap: _isAllowed ? () => _replyComment(widget.comment) : null,
            child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.send,
                    color: _isAllowed ? primaryColor : Colors.grey)),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }

  void _replyComment(CommentEntity comment, {String? content}) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CommentBloc>().add(CreateReplyEvent(
          comment.copyWith(content: content ?? _controller.text)));
    }
  }

  bool get _isAllowed =>
      _controller.text.isNotEmpty &&
      _controller.text.split(' ').length == 2 &&
      _controller.text.split(' ').last.isNotEmpty;
}
