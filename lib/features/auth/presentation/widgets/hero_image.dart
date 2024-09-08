import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final double? height;
  const HeroImage({super.key, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/auth/images/hero-auth.png',
      fit: BoxFit.cover,
      alignment: Alignment.center,
      height: height,
      semanticLabel: 'Hero Illustrator',
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(
          Icons.error,
          size: 100,
          semanticLabel: 'Unavailable Hero Illustrator',
        ),
      ),
    );
  }
}
