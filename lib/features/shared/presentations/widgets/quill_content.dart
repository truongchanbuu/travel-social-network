import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../cores/utils/formatters/quill_content_formatter.dart';

class QuillContent extends StatefulWidget {
  final bool isScrollable;
  final bool isVisible;
  final String content;
  final bool readOnly;
  final Border? border;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const QuillContent({
    super.key,
    required this.content,
    this.isScrollable = false,
    this.isVisible = false,
    this.readOnly = true,
    this.border,
    this.height,
    this.padding,
  });

  @override
  State<QuillContent> createState() => _QuillContentState();
}

class _QuillContentState extends State<QuillContent> {
  late final QuillController _quillController;
  late final FocusNode _focusNode;

  @override
  void dispose() {
    _quillController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void initQuillController() {
    String validatedInput =
        QuillContentFormatter.checkAndConvertQuillFormat(widget.content);
    final document = Document.fromJson(jsonDecode(validatedInput));
    _quillController = QuillController(
      document: document,
      selection: TextSelection.collapsed(offset: document.toDelta().length),
      readOnly: widget.readOnly,
    );
  }

  DefaultTextBlockStyle createDefaultTextBlockStyle(double fontSize) {
    return DefaultTextBlockStyle(
      TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
      const HorizontalSpacing(0, 0),
      const VerticalSpacing(5, 5),
      VerticalSpacing.zero,
      null,
    );
  }

  @override
  void initState() {
    super.initState();
    initQuillController();

    _focusNode = FocusNode(canRequestFocus: false);
  }

  @override
  Widget build(BuildContext context) {
    final paragraphStyle = DefaultTextBlockStyle(
      TextStyle(fontSize: 14, color: DefaultTextStyle.of(context).style.color),
      HorizontalSpacing.zero,
      const VerticalSpacing(5, 5),
      const VerticalSpacing(10, 10),
      null,
    );

    return Stack(
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: defaultFieldBorderRadius,
            border: widget.border,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: QuillEditor(
            focusNode: _focusNode,
            scrollController: ScrollController(),
            controller: _quillController,
            configurations: QuillEditorConfigurations(
              maxHeight: widget.height,
              autoFocus: false,
              enableInteractiveSelection: false,
              expands: widget.isScrollable,
              padding: widget.padding ?? EdgeInsets.zero,
              scrollable: widget.isScrollable,
              showCursor: false,
              customStyles: DefaultStyles(
                paragraph: paragraphStyle,
                h1: createDefaultTextBlockStyle(19),
                h2: createDefaultTextBlockStyle(18),
                h3: createDefaultTextBlockStyle(17),
                h4: createDefaultTextBlockStyle(16),
                h5: createDefaultTextBlockStyle(15),
                h6: createDefaultTextBlockStyle(14),
              ),
            ),
          ),
        ),
        if (!widget.isVisible)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: context.isDarkMode
                      ? [Colors.black38, Colors.black26]
                      : [
                          Colors.white.withOpacity(0.0),
                          Colors.white.withOpacity(0.8),
                        ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
