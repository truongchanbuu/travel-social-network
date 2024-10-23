import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import 'post_item.dart';

class SocialPostList extends StatelessWidget {
  final List<PostEntity> posts;
  const SocialPostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: _buildPostItem,
      itemCount: posts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 5),
    );
  }

  Widget _buildPostItem(BuildContext context, int index) {
    final postItem = posts[index];

    return Container(color: Colors.white, child: PostItem(post: postItem));
  }
}
