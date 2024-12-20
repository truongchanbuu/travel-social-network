import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/save_button.dart';

class AddImagePage extends StatefulWidget {
  final List<ImageFile>? images;
  const AddImagePage({super.key, this.images});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  late final MultiImagePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MultiImagePickerController(
      picker: imagePicker,
      images: widget.images,
      maxImages: maxImageLimit,
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
        actions: [SaveButton(btnColor: Colors.white, onTap: _saveImages)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: MultiImagePickerView(
          builder: (context, imageFile) =>
              DefaultDraggableItemWidget(imageFile: imageFile),
          addMoreButton: const DefaultAddMoreWidget(
            icon: Icon(
              Icons.add,
              color: AppTheme.primaryColor,
            ),
          ),
          initialWidget: DefaultInitialWidget(
            centerWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.image_search,
                  size: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    S.current.addImageLabel,
                    style: const TextStyle(
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

  void _previousPage() async {
    var navigator = Navigator.of(context);

    bool isSaved = false;
    if (_controller.images.isNotEmpty) {
      isSaved = _controller.images.any((img) {
        return widget.images != null && widget.images!.contains(img);
      });

      if (!isSaved) {
        bool isLeave = await showDialog(
          context: context,
          builder: (context) => ConfirmDialog(
            onOk: () => navigator.pop(true),
            onCancel: () => navigator.pop(false),
          ),
        );

        if (isLeave) navigator.pop();
      } else {
        navigator.pop();
      }
    } else {
      navigator.pop();
    }
  }

  void _saveImages() => Navigator.pop(context, _controller.images.toList());
}
