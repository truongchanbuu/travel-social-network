import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class CreateTourImagesPage extends StatefulWidget {
  final List<ImageFile>? images;
  const CreateTourImagesPage({super.key, this.images});

  @override
  State<CreateTourImagesPage> createState() => _CreateTourImagesPageState();
}

class _CreateTourImagesPageState extends State<CreateTourImagesPage> {
  late final MultiImagePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MultiImagePickerController(
      picker: imagePicker,
      images: widget.images,
    );
  }

  Future<List<ImageFile>> imagePicker(bool isAllowed) async {
    final ImagePicker picker = ImagePicker();

    List<XFile> xFiles = await picker.pickMultiImage();
    return xFiles.map((file) => convertXFileToImageFile(file)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _previousPage,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
            onTap: _saveImages,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                S.current.save.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
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

  void _previousPage() {
    bool isSaved = false;
    if (_controller.images.isNotEmpty) {
      isSaved = _controller.images.any((img) {
        return widget.images != null && widget.images!.contains(img);
      });

      if (!isSaved) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              S.current.discardUnsavedWork,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            content: Text(S.current.discardAlertMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  S.current.leave,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  S.current.stay,
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        return;
      }
    }

    Navigator.pop(context);
  }

  void _saveImages() => Navigator.pop(context, _controller.images.toList());
}
