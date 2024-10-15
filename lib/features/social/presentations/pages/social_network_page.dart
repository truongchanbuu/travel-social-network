import 'package:flutter/material.dart';

import '../../../shared/presentations/widgets/app_name_logo.dart';
import '../widgets/social_network_upload_field.dart';
import '../widgets/social_post_list.dart';

class SocialNetworkPage extends StatelessWidget {
  const SocialNetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const AppName());

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SocialNetworkUploadField(),
          ),
          SocialPostList(posts: []),
        ],
      ),
    );
  }
}
