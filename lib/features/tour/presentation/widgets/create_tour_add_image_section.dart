import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/limit_image_list.dart';
import '../pages/create_tour_images_page.dart';

class CreateTourAddImageSection extends StatefulWidget {
  final List<ImageFile> images;
  final void Function(List<ImageFile> images) onImageSaved;
  const CreateTourAddImageSection(
      {super.key, required this.images, required this.onImageSaved});

  @override
  State<CreateTourAddImageSection> createState() =>
      _CreateTourAddImageSectionState();
}

class _CreateTourAddImageSectionState extends State<CreateTourAddImageSection> {
  List<ImageFile> _images = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _images = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isNotEmpty) {
      return _buildImageUI();
    }

    return _buildNoImageUI();
  }

  Widget _buildNoImageUI() {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        width: double.infinity,
        height: createTourImagesBox,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
          borderRadius: inputFieldBorderRadius,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add,
              size: 30,
              color: primaryColor,
            ),
            Text(
              S.current.addImageLabel,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUI() => Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: LimitImageList(
          id: 'TMP',
          imageUrls: _images.map((img) => img.path!).toList(),
          imageSize: 200,
        ),
      );

  void _pickImage(BuildContext context) async {
    var data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTourImagesPage(images: _images),
      ),
    );

    if (data != null) setState(() => _images = data);
    widget.onImageSaved(_images);
  }
}
