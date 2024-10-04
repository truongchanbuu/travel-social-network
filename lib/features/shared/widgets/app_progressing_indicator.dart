import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../cores/constants/constants.dart';

class AppProgressingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final String? text;

  const AppProgressingIndicator({
    super.key,
    this.size = 50,
    this.color = primaryColor,
    this.text,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.waveDots(
              color: color,
              size: size,
            ),
            if (text != null)
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  text!,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                  ),
                  semanticsLabel: text,
                  maxLines: 1,
                  overflow: defaultTextOverflow,
                  textDirection: defaultTextDirection,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      );
}
