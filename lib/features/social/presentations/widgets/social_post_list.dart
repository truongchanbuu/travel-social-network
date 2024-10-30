import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
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

    return Container(
      color: context.isDarkMode
          ? AppTheme.primaryColorDark
          : AppTheme.secondaryColor,
      child: BlocProvider.value(
        value: context.read<UserCubit>()..getUser(postItem.userId),
        child: PostItem(post: postItem),
      ),
    );
  }
}
