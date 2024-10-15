import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';

class SocialPostList extends StatelessWidget {
  final List<PostEntity> posts;
  const SocialPostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: _buildPostItem,
      itemCount: posts.length,
    );
  }

  Widget _buildPostItem(BuildContext context, int index) {
    return Container();
  }
}
