import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/app_name_logo.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../widgets/social_network_upload_field.dart';
import '../widgets/social_post_list.dart';

class SocialNetworkPage extends StatelessWidget {
  const SocialNetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserEntity user =
        context.select((AuthBloc authBloc) => authBloc.state.user);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.3),
        appBar: _buildAppBar(),
        body: _buildBody(context, user),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const AppName());

  Widget _buildBody(BuildContext context, UserEntity user) {
    final List<PostEntity> posts = [];

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () async => _refreshPosts(context),
      child: CustomScrollView(
        slivers: [
          user.isLoggedIn
              ? const SliverToBoxAdapter(child: SocialNetworkUploadField())
              : _buildNoLoginText(),
          const SliverToBoxAdapter(child: SizedBox(height: 5)),
          BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostDeleted) {
                _refreshPosts(context);
              }
            },
            builder: (context, state) {
              if (state is ListOfPostReceived) {
                posts.clear();
                posts.addAll(state.posts);
              }

              return SocialPostList(posts: posts);
            },
            buildWhen: (previous, current) {
              return current is ListOfPostReceived &&
                  previous is ListOfPostReceived &&
                  !const DeepCollectionEquality.unordered()
                      .equals(previous.posts, current.posts);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoLoginText() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            S.current.postNoLoginText,
            style: const TextStyle(fontSize: 14),
            maxLines: 2,
            textAlign: TextAlign.center,
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          ),
        ),
      ),
    );
  }

  void _refreshPosts(BuildContext context) {
    context.read<PostBloc>().add(GetPostsEvent());
  }
}
