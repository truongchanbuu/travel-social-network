import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../cores/constants/constants.dart';
import '../../../generated/l10n.dart';

class EditorPage extends StatefulWidget {
  final String? initialValue;
  const EditorPage({super.key, this.initialValue});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late final QuillController quillController;

  @override
  void initState() {
    super.initState();
    quillController = widget.initialValue?.isEmpty ?? true
        ? QuillController.basic()
        : QuillController(
            document: Document.fromJson(jsonDecode(widget.initialValue!)),
            selection: const TextSelection.collapsed(offset: 0),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          QuillToolbar.simple(
            controller: quillController,
            configurations: QuillSimpleToolbarConfigurations(
              embedButtons: FlutterQuillEmbeds.toolbarButtons(
                imageButtonOptions: const QuillToolbarImageButtonOptions(),
                cameraButtonOptions: const QuillToolbarCameraButtonOptions(),
                videoButtonOptions: const QuillToolbarVideoButtonOptions(),
              ),
            ),
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: quillController,
              focusNode: FocusNode(),
              scrollController: ScrollController(),
              configurations: QuillEditorConfigurations(
                embedBuilders: kIsWeb
                    ? FlutterQuillEmbeds.editorWebBuilders()
                    : FlutterQuillEmbeds.editorBuilders(),
                padding: const EdgeInsets.all(defaultPadding),
                textInputAction: TextInputAction.next,
                placeholder: S.current.editingPlaceholderText,
                autoFocus: true,
                scrollable: true,
                customStyles: const DefaultStyles(
                  placeHolder: DefaultListBlockStyle(
                    TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      overflow: defaultTextOverflow,
                    ),
                    HorizontalSpacing(5, 5),
                    VerticalSpacing(5, 5),
                    VerticalSpacing.zero,
                    BoxDecoration(),
                    null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        leading: IconButton(
          onPressed: _backToCreateTourPage,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: _saveDescription,
              child: Text(
                S.current.save.toUpperCase(),
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: defaultTextOverflow,
                textDirection: defaultTextDirection,
              ),
            ),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          S.current.editPage,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textDirection: defaultTextDirection,
          overflow: defaultTextOverflow,
        ),
      );

  void _backToCreateTourPage() {
    String processedString = _processContent();
    if (processedString != (widget.initialValue ?? '')) {
      _showAlert();
      return;
    }

    Navigator.pop(context);
  }

  String _processContent() {
    final Delta delta = quillController.document.toDelta();
    final List<Map<String, dynamic>> json = delta.toJson();

    if (json.isEmpty || (json.length == 1 && json[0]['insert'] == '\n')) {
      return '';
    }

    bool allWhitespace = json
        .every((op) => op['insert'] is String && op['insert'].trim().isEmpty);

    return allWhitespace ? '' : jsonEncode(json);
  }

  void _showAlert() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            S.current.discardUnsavedWork,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          ),
          content: Text(
            S.current.discardAlertMessage,
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                S.current.stay,
                style: const TextStyle(color: primaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                S.current.leave,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );

  void _saveDescription() {
    String processedString = _processContent();
    Navigator.pop(context, processedString);
  }
}
