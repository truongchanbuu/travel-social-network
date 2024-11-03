import 'dart:developer' as dev;
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../auth/domain/entities/user.dart';

class UserAvatar extends StatelessWidget {
  final double? radius;
  final UserEntity user;
  const UserAvatar({super.key, required this.user, this.radius});

  static const List<String> randomCats = [
    '98472b866d8abfe7c01ca28cadfa4bac',
    '803b889fd096f03437835d4452f4cbf6',
    '07dc89a6e7fe71291ffc3e8839bdee9f',
    '7cd4b755d4a724016566dd228eb22f36',
    '33598c7e1ba53542dd3cf989b79a98c7',
    'fabf8f1c266605bcd045ea28409b3815',
    '47fdb19b335136327329015cb8f2c53f',
  ];

  @override
  Widget build(BuildContext context) {
    final randomCatUrl = randomCats[Random().nextInt(randomCats.length)];
    final avatarUrl = user.avatarUrl ??
        'https://robohash.org/$randomCatUrl?set=set4&bgset=&size=400x400';

    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
        avatarUrl,
        cacheKey: (user.avatarUrl?.isNotEmpty ?? false)
            ? '${user.avatarUrl}_${user.avatarUrl}_${DateTime.now().millisecondsSinceEpoch}'
            : user.email ?? user.id,
      ),
      backgroundColor: Colors.white,
      onBackgroundImageError: (exception, stackTrace) =>
          dev.log('Failed to load avatar: $exception'),
      radius: radius,
    );
  }

  String _getName() {
    return (user.username ?? user.email ?? 'Unknown')[0];
  }
}
