import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/app_name_logo.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../widgets/social_network_upload_field.dart';
import '../widgets/social_post_list.dart';

class SocialNetworkPage extends StatefulWidget {
  const SocialNetworkPage({super.key});

  @override
  State<SocialNetworkPage> createState() => _SocialNetworkPageState();
}

class _SocialNetworkPageState extends State<SocialNetworkPage>
    with AutomaticKeepAliveClientMixin {
  final List<PostEntity> _posts = [];
  bool _isLoading = true;
  String? _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Delay to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshPosts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
    return RefreshIndicator(
      color: AppTheme.primaryColor,
      onRefresh: () async {
        setState(() {
          _isLoading = true;
          _error = null;
        });
        _refreshPosts(context);
      },
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
              } else if (state is PostActionFailed) {
                setState(() {
                  _error = state.message;
                  _isLoading = false;
                });
              }
            },
            builder: (context, state) {
              if (state is ListOfPostReceived) {
                _posts.clear();
                _posts.addAll(state.posts);
                _isLoading = false;
                _error = null;
              }

              if (_error != null) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _refreshPosts(context),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (_isLoading && _posts.isEmpty) {
                return const SliverFillRemaining(
                  child: AppProgressingIndicator(),
                );
              }

              return SocialPostList(posts: _posts);
            },
            buildWhen: (previous, current) {
              return current is ListOfPostReceived ||
                  current is PostActionFailed ||
                  (current is PostActionLoading && _posts.isEmpty);
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
