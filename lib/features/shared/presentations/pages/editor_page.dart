import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/formatters/quill_content_formatter.dart';
import '../../../../generated/l10n.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/default_white_appbar.dart';
import '../widgets/save_button.dart';

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
    initController();
  }

  void initController() {
    if (widget.initialValue?.isEmpty ?? true) {
      quillController = QuillController.basic();
    } else {
      final doc = Document.fromJson(jsonDecode(
          QuillContentFormatter.checkAndConvertQuillFormat(
              widget.initialValue!)));

      quillController = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (quillController.document.length > 0) {
          quillController.updateSelection(
            TextSelection.collapsed(
                offset: quillController.document.toPlainText().length),
            ChangeSource.local,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
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
                textInputAction: TextInputAction.newline,
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

  AppBar _buildAppBar(BuildContext context) => defaultWhiteAppBar(
        context: context,
        onBack: () => _backToCreateTourPage(context),
        actions: [SaveButton(onTap: _saveDescription)],
        titleText: S.current.editPage,
      );

  void _backToCreateTourPage(BuildContext ctx) {
    String processedString = _processContent();
    if (processedString != (widget.initialValue ?? '')) {
      _showAlert(ctx);
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

  void _showAlert(BuildContext ctx) => showDialog(
        context: ctx,
        builder: (context) => ConfirmDialog(onOk: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
        }),
      );

  void _saveDescription() {
    String processedString = _processContent();
    Navigator.pop(context, processedString);
  }
}
