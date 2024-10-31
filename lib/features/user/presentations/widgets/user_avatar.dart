import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../auth/domain/entities/user.dart';

class UserAvatar extends StatelessWidget {
  final double? radius;
  final UserEntity user;
  const UserAvatar({super.key, required this.user, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
        user.avatarUrl ?? '',
        cacheKey: '${user.avatarUrl}_${DateTime.now().millisecondsSinceEpoch}',
      ),
      onBackgroundImageError: (exception, stackTrace) =>
          log('Failed to load avatar: $exception'),
      radius: radius,
      child: (user.avatarUrl?.isEmpty ?? true)
          ? Text(
              _getName(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )
          : null,
    );
  }

  String _getName() {
    return (user.username ?? user.email ?? 'Unknown')[0];
  }
}
