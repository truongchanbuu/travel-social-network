import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      child: Image(
        image: const Svg('assets/auth/images/female_avatars.svg'),
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.person,
          size: 30,
        ),
      ),
    );
  }
}