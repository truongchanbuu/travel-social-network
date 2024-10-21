import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../comment/presentations/bloc/comment_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CommentBloc>()
          .add(GetPostCommentsEvent(posts[index].postId));
    });

    return Container(color: Colors.white, child: PostItem(post: posts[index]));
  }
}
