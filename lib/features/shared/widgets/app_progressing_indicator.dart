import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppProgressingIndicator extends StatelessWidget {
  final double size;

  const AppProgressingIndicator({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) => Center(
        child: LoadingAnimationWidget.waveDots(
          color: Colors.white,
          size: size,
        ),
      );
}
