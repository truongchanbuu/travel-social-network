import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentations/widgets/app_name_logo.dart';
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
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const AppName());

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SocialNetworkUploadField(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 5)),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              return SocialPostList(
                posts: state is ListOfPostReceived ? state.posts : [],
              );
            },
          ),
        ],
      ),
    );
  }
}
