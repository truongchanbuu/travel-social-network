import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../domain/entities/comment.dart';

class ReplyInput extends StatefulWidget {
  final CommentEntity comment;
  const ReplyInput({super.key, required this.comment});

  @override
  State<ReplyInput> createState() => _ReplyInputState();
}

class _ReplyInputState extends State<ReplyInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.comment.content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (value) => _controller.text = value,
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
          onTap: _replyComment,
          child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.send, color: primaryColor)),
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }

  void _replyComment() {
    print(_controller.text);
  }
}
