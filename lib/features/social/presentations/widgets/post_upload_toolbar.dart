import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/pages/add_image_page.dart';
import '../../data/models/post_toolbar_item.dart';
import '../bloc/post_bloc.dart';
import 'post_toolbar_bottom_sheet.dart';

class PostUploadToolbar extends StatelessWidget {
  final List<ImageFile>? images;
  const PostUploadToolbar({super.key, this.images});

  static final List<PostToolbarItem> items = [
    PostToolbarItem(
      text: S.current.image,
      icon: Icons.image,
      iconColor: Colors.green,
    ),
    const PostToolbarItem(
      text: 'Check in',
      icon: Icons.location_on,
      iconColor: Colors.red,
    ),
    PostToolbarItem(
      text: S.current.emotion,
      icon: Icons.emoji_emotions,
      iconColor: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => _onImage(context),
            icon: const Icon(
              Icons.image,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.location_on,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions,
              color: Colors.orange,
            ),
          ),
          IconButton(
            onPressed: () => _onBottomSheet(context),
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _onImage(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var data = await Navigator.push(
        context,
        PageTransition(
          child: AddImagePage(images: images),
          type: PageTransitionType.leftToRight,
        ));

    postBloc
        .add(UpdateContentEvent(images: data, content: postBloc.state.content));
  }

  void _onBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: bottomSheetShape,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => const PostToolbarBottomSheet(),
    );
  }
}
