import 'package:flutter/material.dart';

import '../../../cores/constants/constants.dart';
import '../../../generated/l10n.dart';

class ConfirmDialog extends StatelessWidget {
  final void Function()? onLeaved;
  final void Function()? onStay;
  const ConfirmDialog({super.key, this.onLeaved, this.onStay});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.current.discardUnsavedWork,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Text(S.current.discardAlertMessage),
      actions: [
        TextButton(
          onPressed: onLeaved ??
              () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
          child: Text(
            S.current.leave,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onStay ?? () => Navigator.pop(context),
          child: Text(
            S.current.stay,
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
