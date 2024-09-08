import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SocialIcon extends StatelessWidget {
  final String label;
  final String imageUrl;
  final Color? imageColor;
  final double? size;
  final Color? iconColor;
  final IconData? iconData;

  const SocialIcon({
    super.key,
    required this.label,
    required this.imageUrl,
    this.imageColor,
    this.iconColor,
    this.size,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: Svg(imageUrl, color: imageColor),
      width: size,
      height: size,
      fit: BoxFit.cover,
      semanticLabel: label,
      errorBuilder: (context, error, stackTrace) => Icon(
        iconData ?? Icons.error,
        color: iconColor ?? Colors.white,
        semanticLabel: label,
        size: size,
      ),
    );
  }
}
