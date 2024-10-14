import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../bloc/post_bloc.dart';
import '../widgets/post_upload_toolbar.dart';
import '../widgets/uploaded_image_section.dart';

class PostUploadPage extends StatelessWidget {
  const PostUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) => Scaffold(
          appBar: _buildAppBar(state),
          body: _buildBody(context, state),
          bottomNavigationBar: PostUploadToolbar(
            images: state is ContentUpdated ? state.images : [],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(PostState state) =>
      defaultWhiteAppBar(titleText: S.current.createPost, actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: state is ContentUpdated &&
                    (state.images.isNotEmpty || state.content.isNotEmpty)
                ? () {}
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
              hintText: S.current.howYourFeeling,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => context
                .read<PostBloc>()
                .add(UpdateContentEvent(content: value, images: state.images)),
          ),
          if (state is ContentUpdated && state.images.isNotEmpty)
            UploadedImageSection(images: state.images),
        ],
      ),
    );
  }
}
