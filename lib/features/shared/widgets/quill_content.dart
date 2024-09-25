import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../cores/constants/constants.dart';

class QuillContent extends StatelessWidget {
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

  DefaultTextBlockStyle createDefaultTextBlockStyle(double fontSize) {
    return DefaultTextBlockStyle(
      TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: Colors.black,
      ),
      const HorizontalSpacing(0, 0),
      const VerticalSpacing(5, 5),
      VerticalSpacing.zero,
      null,
    );
  }

  static const _paragraphStyle = DefaultTextBlockStyle(
    TextStyle(fontSize: 14, color: Colors.black),
    HorizontalSpacing.zero,
    VerticalSpacing(5, 5),
    VerticalSpacing(10, 10),
    null,
  );

  @override
  Widget build(BuildContext context) {
    final document = Document.fromJson(jsonDecode(content));

    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: defaultFieldBorderRadius,
            border: border,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: QuillEditor(
            focusNode: FocusNode(canRequestFocus: false),
            scrollController: ScrollController(),
            controller: QuillController(
              document: document,
              selection: const TextSelection.collapsed(offset: 0),
              readOnly: readOnly,
            ),
            configurations: QuillEditorConfigurations(
              maxHeight: height,
              autoFocus: false,
              enableInteractiveSelection: false,
              expands: isScrollable,
              padding: padding ?? EdgeInsets.zero,
              scrollable: isScrollable,
              showCursor: false,
              customStyles: DefaultStyles(
                paragraph: _paragraphStyle,
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
        if (!isVisible)
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
                  colors: [
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
