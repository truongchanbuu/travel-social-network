import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../shared/presentations/widgets/app_name_logo.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../widgets/social_network_upload_field.dart';
import '../widgets/social_post_list.dart';

class SocialNetworkPage extends StatelessWidget {
  const SocialNetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.3),
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const AppName());

  Widget _buildBody(BuildContext context) {
    List<PostEntity> posts = [];
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () async => _refreshPosts(context),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SocialNetworkUploadField(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 5)),
          BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostDeleted) {
                _refreshPosts(context);
              }
            },
            builder: (context, state) {
              if (state is ListOfPostReceived) {
                posts = state.posts;
              }

              return SocialPostList(posts: posts);
            },
            buildWhen: (previous, current) {
              return current is ListOfPostReceived &&
                  (previous is! ListOfPostReceived ||
                      (!const DeepCollectionEquality.unordered()
                          .equals(previous.posts, current.posts)));
            },
          ),
        ],
      ),
    );
  }

  void _refreshPosts(BuildContext context) {
    context.read<PostBloc>().add(GetPostsEvent());
  }
}
