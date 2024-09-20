import 'package:flutter/material.dart';

import '../../../cores/constants/constants.dart';

class AppProgressingIndicator extends StatelessWidget {
  final double size;
  final String? semanticLabel;
  final double? value;
  const AppProgressingIndicator({
    super.key,
    this.size = 50,
    this.semanticLabel,
    this.value,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: Center(
          child: CircularProgressIndicator(
            value: value,
            semanticsValue: '${value ?? 0 * 100}%',
            backgroundColor: primaryColor,
            semanticsLabel: semanticLabel ?? 'Loading',
          ),
        ),
      );
}
