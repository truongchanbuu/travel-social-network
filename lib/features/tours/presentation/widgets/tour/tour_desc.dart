import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TourDesc extends StatelessWidget {
  final bool isScrollable;
  final String content;
  const TourDesc({super.key, required this.content, this.isScrollable = false});

  DefaultTextBlockStyle createDefaultTextBlockStyle(double fontSize) {
    return DefaultTextBlockStyle(
      TextStyle(
          fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.black),
      const HorizontalSpacing(0, 0),
      const VerticalSpacing(5, 5),
      VerticalSpacing.zero,
      null,
    );
  }

  static const _paragraphStyle = DefaultTextBlockStyle(
    TextStyle(fontSize: 16, color: Colors.black),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            child: QuillEditor(
              focusNode: FocusNode(canRequestFocus: false),
              scrollController: ScrollController(),
              controller: QuillController(
                document: document,
                selection: const TextSelection.collapsed(offset: 0),
                readOnly: true,
              ),
              configurations: QuillEditorConfigurations(
                autoFocus: false,
                enableInteractiveSelection: false,
                expands: isScrollable,
                padding: EdgeInsets.zero,
                scrollable: isScrollable,
                showCursor: false,
                customStyles: DefaultStyles(
                  paragraph: _paragraphStyle,
                  h1: createDefaultTextBlockStyle(24),
                  h2: createDefaultTextBlockStyle(23),
                  h3: createDefaultTextBlockStyle(22),
                  h4: createDefaultTextBlockStyle(21),
                  h5: createDefaultTextBlockStyle(20),
                  h6: createDefaultTextBlockStyle(17),
                ),
              ),
            ),
          ),
        ),
        if (!isScrollable)
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
