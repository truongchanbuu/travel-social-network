import 'package:flutter/material.dart';

import '../../../cores/constants/constants.dart';
import '../../../generated/l10n.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? strongActionText;
  final String? softActionText;
  final void Function()? onCancel;
  final void Function()? onOk;

  const ConfirmDialog({
    super.key,
    this.title,
    this.content,
    this.strongActionText,
    this.softActionText,
    this.onCancel,
    this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? S.current.discardUnsavedWork,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Text(content ?? S.current.discardAlertMessage),
      actions: [
        TextButton(
          onPressed: onCancel ??
              () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
          child: Text(
            strongActionText ?? S.current.leave,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onOk ?? () => Navigator.pop(context),
          child: Text(
            softActionText ?? S.current.stay,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
