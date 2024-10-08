import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class SaveButton extends StatelessWidget {
  final Color btnColor;
  final VoidCallback? onTap;
  const SaveButton({super.key, this.btnColor = primaryColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          S.current.save.toUpperCase(),
          style: TextStyle(
            color: btnColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
