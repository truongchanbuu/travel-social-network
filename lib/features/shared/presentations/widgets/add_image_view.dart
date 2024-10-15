import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../pages/add_image_page.dart';
import 'limit_image_list.dart';

class AddImageView extends StatefulWidget {
  final List<ImageFile> images;
  final void Function(List<ImageFile> images) onImageSaved;

  const AddImageView({
    super.key,
    this.images = const [],
    required this.onImageSaved,
  });

  @override
  State<AddImageView> createState() => _AddImageViewState();
}

class _AddImageViewState extends State<AddImageView> {
  List<ImageFile> _images = [];

  @override
  void initState() {
    super.initState();
    _images = widget.images;
  }

  static const String templateIdString = 'TMP_IMG';
  @override
  Widget build(BuildContext context) {
    if (_images.isNotEmpty) {
      return _buildImagesWidget();
    }

    return _buildPickerWidget();
  }

  Widget _buildPickerWidget() {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        color: Colors.transparent,
        child: Center(
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
      ),
    );
  }

  Widget _buildImagesWidget() => Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: LimitImageList(
          id: templateIdString,
          imageUrls: _images.map((img) => img.path!).toList(),
          imageSize: 200,
          overflowWidget: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _buildPickerWidget(),
          ),
        ),
      );

  void _pickImage(BuildContext context) async {
    var data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddImagePage(images: _images)),
    );

    if (data != null) setState(() => _images = data);
    widget.onImageSaved(_images);
  }
}
