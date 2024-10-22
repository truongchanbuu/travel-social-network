import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.current.next,
            style: const TextStyle(
              color: textButtonColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
