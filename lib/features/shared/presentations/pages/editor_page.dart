import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:travel_social_network/features/shared/presentations/widgets/confirm_dialog.dart';
import 'package:travel_social_network/features/shared/presentations/widgets/default_white_appabar.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/formatters/quill_content_formatter.dart';
import '../../../../generated/l10n.dart';
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
          document: doc,
          selection: TextSelection.collapsed(offset: doc.length));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (quillController.document.length > 0) {
          quillController.updateSelection(
            TextSelection.collapsed(offset: quillController.document.length),
            ChangeSource.local,
          );
        }
      });
    }
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

  AppBar _buildAppBar() => defaultWhiteAppBar(
        onBack: _backToCreateTourPage,
        actions: [SaveButton(onTap: _saveDescription)],
        titleText: S.current.editPage,
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
        builder: (context) => const ConfirmDialog(),
      );

  void _saveDescription() {
    String processedString = _processContent();
    Navigator.pop(context, processedString);
  }
}
