import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'confirm_dialog.dart';

Future<bool> confirmDeletion(
  BuildContext context, {
  String? confirmTitle,
  String? confirmMessage,
}) async {
  bool? result = await showDialog(
    context: context,
    builder: (context) => ConfirmDialog(
      title: confirmTitle,
      content: confirmMessage,
      softActionText: S.current.cancel,
      strongActionText: S.current.delete,
      onOk: () => Navigator.pop(context, true),
      onCancel: () => Navigator.pop(context, false),
    ),
  );

  return result ?? false;
}
