import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../pages/post_upload_page.dart';
import 'post_content.dart';
import 'post_footer.dart';
import 'post_header.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(
              post: _getPost(state),
              onDelete: () => _deletePost(context),
              onEdit: () => _editPost(context),
            ),
            PostContent(post: _getPost(state)),
            PostFooter(post: _getPost(state)),
          ],
        );
      },
      buildWhen: (previous, current) => current is PostReceived,
    );
  }

  void _deletePost(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var confirmed = await confirmDeletion(
      context,
      confirmTitle: S.current.deleteConfirmTitle,
      confirmMessage: S.current.deleteConfirmText,
    );

    if (confirmed) {
      postBloc.add(DeletePostById(post.postId));
    }
  }

  void _editPost(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var data = await Navigator.push(
      context,
      PageTransition(
        child: BlocProvider(
          create: (context) =>
              getIt.get<PostBloc>()..add(GetPostByIdEvent(post.postId)),
          child: const PostUploadPage(),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );

    if (data != null && data is PostEntity && data != post) {
      postBloc.add(GetPostByIdEvent(data.postId));
    }
  }

  PostEntity _getPost(PostState state) {
    return state is PostReceived && state.post.postId == post.postId
        ? state.post
        : post;
  }
}
