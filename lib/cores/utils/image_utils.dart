import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:mime/mime.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../features/shared/domain/repositories/image_repository.dart';
import '../../injection_container.dart';
import '../resources/data_state.dart';

class ImageUtils {
  static final ImageRepository imageRepository = getIt.get<ImageRepository>();

  static Future<File?> createTmpFile(Uint8List data, String? mimeType) async {
    if (mimeType != null) {
      try {
        final tempDir = await getTemporaryDirectory();
        final extension = extensionFromMime(mimeType);
        final tempFile = File('${tempDir.path}/${const Uuid().v4()}$extension');
        await tempFile.writeAsBytes(data);
        return tempFile;
      } catch (e) {
        log(e.toString());
      }
    }

    return null;
  }

  static Future<String?> uploadImage(ImageFile image, String path) async {
    try {
      var data = image.hasPath ? image.path : image.bytes;
      final dataState = await imageRepository.uploadImage(data, path);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'There some error ${dataState.error}');
        return null;
      }

      return dataState.data;
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  static Future<List<ImageFile>?> getFolderImages(String path) async {
    try {
      final dataState = await imageRepository.getFolderImages(path);

      if (dataState is DataSuccess) {
        return dataState.data!;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}
