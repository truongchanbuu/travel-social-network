import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../widgets/post_upload_toolbar.dart';
import '../widgets/share_post_widget.dart';
import '../widgets/uploaded_image_section.dart';

class PostUploadPage extends StatefulWidget {
  final PostEntity? sharedPost;
  const PostUploadPage({super.key, this.sharedPost});

  @override
  State<PostUploadPage> createState() => _PostUploadPageState();
}

class _PostUploadPageState extends State<PostUploadPage> {
  late final TextEditingController _controller;
  PostEntity? post;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc authBloc) => authBloc.state.user);
    return SafeArea(
      child: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostActionSucceed) {
            showToast(S.current.success, context: context);
            Navigator.pop(context, state.post);
          } else if (state is PostActionFailed) {
            showToast(state.message, context: context);
          } else if (state is PostReceived) {
            post = state.post;
          }
        },
        builder: (context, state) => Scaffold(
          appBar: _buildAppBar(context, state, user.id),
          body: state is PostActionLoading
              ? const AppProgressingIndicator()
              : _buildBody(context, state),
          bottomNavigationBar: PostUploadToolbar(
            images: state is ContentUpdated ? state.images : [],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, PostState state, String userId) =>
      defaultWhiteAppBar(
          context: context,
          titleText: S.current.createPost,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: state is ContentUpdated &&
                        (state.images.isNotEmpty || state.content.isNotEmpty)
                    ? () => _onPost(context, userId)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
                child: Text(
                  S.current.post,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ]);

  Widget _buildBody(BuildContext context, PostState state) {
    if (state is ContentUpdated) {
      _controller.text = state.content;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            autofocus: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
              hintText: widget.sharedPost != null
                  ? S.current.whatYouThinkAboutThisPost
                  : S.current.howYourFeeling,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            onChanged: (value) => context
                .read<PostBloc>()
                .add(UpdateContentEvent(content: value, images: state.images)),
          ),
          if (state is ContentUpdated && state.images.isNotEmpty)
            UploadedImageSection(images: state.images),
          if (widget.sharedPost != null)
            SharePostWidget(post: widget.sharedPost!),
        ],
      ),
    );
  }

  void _onPost(BuildContext context, String userId) {
    context.read<PostBloc>().add(SavePostEvent(
          userId: userId,
          post: post,
          sharedPostId: widget.sharedPost?.postId,
        ));
  }
}
