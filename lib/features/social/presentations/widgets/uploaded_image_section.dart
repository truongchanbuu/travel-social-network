import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/pages/add_image_page.dart';
import '../../../shared/presentations/widgets/limit_image_gridview.dart';
import '../bloc/post_bloc.dart';

class UploadedImageSection extends StatelessWidget {
  final List<ImageFile> images;
  const UploadedImageSection({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LimitImageGridView(
          images: images
              .where((img) => img.hasPath)
              .map((img) => img.path!)
              .toList(),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _addMoreImage(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate_outlined,
                color: primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                S.current.addImageLabel,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _addMoreImage(BuildContext context) async {
    final postBloc = context.read<PostBloc>();
    var data = await Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: AddImagePage(images: images),
      ),
    );

    postBloc
        .add(UpdateContentEvent(images: data, content: postBloc.state.content));
  }
}
