import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../comment/presentations/bloc/comment_bloc.dart';
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
    return BlocProvider.value(
      value: context.read<CommentBloc>()
        ..add(GetPostCommentsEvent(post.postId)),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, postState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostHeader(
                post: _getPost(postState),
                onDelete: () => _deletePost(context),
                onEdit: () => _editPost(context),
              ),
              PostContent(post: _getPost(postState)),
              PostFooter(post: _getPost(postState)),
            ],
          );
        },
        buildWhen: (previous, current) =>
            current is PostReceived && _isPostChanged(current),
      ),
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
              getIt.get<PostBloc>()..add(EditPostProgressEvent(post.postId)),
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

  bool _isPostChanged(PostReceived current) {
    return current.post.postId == post.postId &&
        (current.post.refPostId != post.refPostId ||
            current.post.content != post.content ||
            !const DeepCollectionEquality.unordered()
                .equals(current.post.sharedBy, post.sharedBy) ||
            !const DeepCollectionEquality.unordered()
                .equals(current.post.images, post.images) ||
            !const DeepCollectionEquality.unordered()
                .equals(current.post.likedUsers, post.likedUsers));
  }
}
