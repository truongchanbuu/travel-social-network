import 'package:flutter/material.dart';

import '../../../cores/constants/constants.dart';
import '../pages/editor_page.dart';
import 'custom_text_field.dart';
import 'quill_content.dart';

class LongTextField extends StatefulWidget {
  final String title;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;

  const LongTextField({
    super.key,
    required this.title,
    this.onSaved,
    this.validator,
  });

  @override
  State<LongTextField> createState() => _LongTextFieldState();
}

class _LongTextFieldState extends State<LongTextField> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  String? _content;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: _content);
    _focusNode = FocusNode()..addListener(_unFocus);
  }

  void _unFocus() {
    if (_content?.isNotEmpty ?? false) {
      _focusNode.unfocus();
    }
  }

  // TODO: Add image feature
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      validator: widget.validator,
      label: widget.title,
      readOnly: true,
      enable: true,
      focusNode: _focusNode,
      textEditingController: _textEditingController,
      maxLines: 4,
      singleHintText: widget.title,
      onTap: _openQuillEditor,
      replaceField: _content?.isEmpty ?? true
          ? null
          : QuillContent(
              height: createTourFieldHeight,
              content: _content!,
              readOnly: false,
              isVisible: true,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              border: Border.all(width: 1, color: defaultFieldBorderColor),
            ),
    );
  }

  void _openQuillEditor() async {
    var data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditorPage(initialValue: _content),
      ),
    );

    setState(() {
      if (data?.isNotEmpty ?? false) {
        _content = data;
        _textEditingController.text = _content!;
        widget.onSaved?.call(_content);
      }
    });
  }
}
