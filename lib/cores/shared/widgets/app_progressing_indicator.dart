import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AppProgressingIndicator extends StatelessWidget {
  final double? size;
  final String? sematicLabel;
  final double? value;
  const AppProgressingIndicator({
    super.key,
    this.size,
    this.sematicLabel,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Center(
        child: CircularProgressIndicator(
          value: value,
          semanticsValue: '$value%',
          backgroundColor: primaryColor,
          semanticsLabel: sematicLabel ?? 'Loading',
        ),
      ),
    );
  }
}
