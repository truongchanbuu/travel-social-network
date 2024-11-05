import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/pages/add_image_page.dart';
import '../../data/models/post_toolbar_item.dart';
import '../bloc/post_bloc.dart';

class PostUploadToolbar extends StatelessWidget {
  final String content;
  final List<ImageFile>? images;
  const PostUploadToolbar({super.key, this.images, this.content = ''});

  static const IconData imageIconData = Icons.image;
  static const IconData checkInIconData = Icons.location_on;
  static const IconData emojiIconData = Icons.emoji_emotions;
  static const IconData moreIconData = Icons.more_horiz;

  static final List<PostToolbarItem> items = [
    PostToolbarItem(
      text: S.current.image,
      icon: imageIconData,
      iconColor: Colors.green,
    ),
    const PostToolbarItem(
      text: 'Check in',
      icon: checkInIconData,
      iconColor: Colors.red,
    ),
    PostToolbarItem(
      text: S.current.emotion,
      icon: emojiIconData,
      iconColor: Colors.orange,
    ),
    PostToolbarItem(
      text: S.current.moreInfo,
      icon: moreIconData,
      iconColor: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) => _buildToolbars(context, item)).toList(),
      ),
    );
  }

  Widget _buildToolbars(BuildContext context, PostToolbarItem item) {
    return IconButton(
      onPressed: () => _getOnPressed(
        context,
        item.icon,
      ),
      icon: Icon(
        item.icon,
        color: item.iconColor,
      ),
    );
  }

  void _getOnPressed(BuildContext context, IconData iconData) {
    switch (iconData) {
      case imageIconData:
        _onImage(context);
        break;
      case moreIconData:
        _onBottomSheet(context);
        break;
    }
  }

  void _onImage(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var data = await Navigator.push(
        context,
        PageTransition(
          child: AddImagePage(images: images),
          type: PageTransitionType.leftToRight,
        ));

    postBloc.add(UpdateContentEvent(images: data, content: content));
  }

  void _onBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      shape: bottomSheetShape,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .take(items.length - 1)
            .map((item) => _buildItem(ctx, item))
            .toList(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, PostToolbarItem item) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _getOnPressed(context, item.icon);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
        ),
        child: ListTile(
          leading: Icon(
            item.icon,
            color: item.iconColor,
          ),
          title: Text(item.text),
        ),
      ),
    );
  }
}
