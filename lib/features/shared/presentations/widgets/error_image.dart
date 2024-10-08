import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  final double? size;
  final IconData icon;
  final String? semanticLabel;
  const ErrorImage({
    super.key,
    this.size = 50,
    this.icon = Icons.image,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: Icon(
          icon,
          size: size,
          color: Colors.grey,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}
