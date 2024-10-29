import 'package:flutter/material.dart';

import '../../../auth/domain/entities/user.dart';
import '../../../shared/presentations/widgets/app_cached_image.dart';

class UserAvatar extends StatelessWidget {
  final UserEntity user;
  const UserAvatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.orange,
      child: AppCachedImage(
        cacheKey: 'avatar_${user.avatarUrl}',
        imageUrl: user.avatarUrl ?? '',
        errorImage: Text(_getName()),
      ),
    );
  }

  String _getName() {
    return (user.username ?? user.email ?? 'Unknown')[0];
  }
}
