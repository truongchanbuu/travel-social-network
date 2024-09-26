import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/quill_content.dart';
import '../pages/tour_desc_editor_page.dart';
import 'create_tour_field.dart';

class TourDescField extends StatefulWidget {
  final void Function(String? value)? onSaved;
  const TourDescField({super.key, this.onSaved});

  @override
  State<TourDescField> createState() => _TourDescFieldState();
}

class _TourDescFieldState extends State<TourDescField> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  String? _tourDesc;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: _tourDesc);
    _focusNode = FocusNode()..addListener(_unFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_unFocus);
    _focusNode.dispose();
    _textEditingController.dispose();
  }

  void _unFocus() {
    if (_tourDesc?.isNotEmpty ?? false) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CreateTourField(
      validator: _validator,
      label: S.current.tourDescLabel,
      readOnly: true,
      enable: true,
      focusNode: _focusNode,
      textEditingController: _textEditingController,
      maxLines: 4,
      singleHintText: S.current.tourDescLabel,
      onTap: _openQuillEditor,
      replaceField: _tourDesc?.isEmpty ?? true
          ? null
          : QuillContent(
              height: createTourFieldHeight,
              content: _tourDesc!,
              readOnly: false,
              isVisible: true,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              border: Border.all(width: 1, color: createTourFieldBorderColor),
            ),
    );
  }

  void _openQuillEditor() async {
    var data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TourDescEditorPage(initialValue: _tourDesc),
      ),
    );

    setState(() {
      if (data?.isNotEmpty ?? false) {
        _tourDesc = data;
        _textEditingController.text = _tourDesc!;
        widget.onSaved?.call(_tourDesc);
      }
    });
  }

  String? _validator(String? value) {
    if ((value?.isEmpty ?? true) || value!.length < 10) {
      return S.current.invalidTourDescError;
    }

    return null;
  }
}
