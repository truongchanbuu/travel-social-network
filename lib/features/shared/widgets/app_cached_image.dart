import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_progressing_indicator.dart';
import 'error_image.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final String cacheKey;
  final String? errorSemanticLabel;
  final String? loadingSemanticLabel;
  final double loadingIndicatorSize;
  final double? errorImageSize;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    required this.cacheKey,
    this.errorSemanticLabel,
    this.loadingSemanticLabel,
    this.loadingIndicatorSize = 50,
    this.errorImageSize,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      cacheKey: cacheKey,
      errorWidget: (context, error, stackTrace) =>
          ErrorImage(semanticLabel: errorSemanticLabel, size: errorImageSize),
      progressIndicatorBuilder: (context, child, loadingProgress) =>
          AppProgressingIndicator(
        size: loadingIndicatorSize,
        semanticLabel: loadingSemanticLabel,
        value: loadingProgress.progress,
      ),
    );
  }
}
