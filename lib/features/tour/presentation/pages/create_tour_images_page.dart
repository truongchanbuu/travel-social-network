import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class CreateTourImagesPage extends StatefulWidget {
  const CreateTourImagesPage({super.key});

  @override
  State<CreateTourImagesPage> createState() => _CreateTourImagesPageState();
}

class _CreateTourImagesPageState extends State<CreateTourImagesPage> {
  late final MultiImagePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MultiImagePickerController(picker: imagePicker);
  }

  Future<List<ImageFile>> imagePicker(bool isAllowed) async {
    final ImagePicker picker = ImagePicker();

    List<XFile> xFiles = await picker.pickMultiImage();
    return xFiles.map((file) => convertXFileToImageFile(file)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: MultiImagePickerView(
          builder: (context, imageFile) =>
              DefaultDraggableItemWidget(imageFile: imageFile),
          addMoreButton: const DefaultAddMoreWidget(
              icon: Icon(Icons.add, color: primaryColor)),
          initialWidget: DefaultInitialWidget(
            centerWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.image_search,
                  size: 40,
                  color: primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    S.current.addImageLabel,
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          controller: _controller,
        ),
      ),
    );
  }
}
