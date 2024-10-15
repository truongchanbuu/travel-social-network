import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart' as path;
import 'package:travel_social_network/cores/utils/image_utils.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final FirebaseStorage _storage = getIt.get<FirebaseStorage>();

  @override
  Future<DataState<dynamic>> deleteImage(String path) async {
    try {
      final ref = _storage.ref(path);
      await ref.delete();
      return const DataSuccess();
    } on FirebaseException catch (e) {
      return handleFirebaseException<String>(e);
    } catch (e) {
      return defaultDataFailure<String>(e.toString());
    }
  }

  @override
  Future<DataState<String>> getImageUrl(String path) async {
    try {
      final ref = _storage.ref(path);
      return DataSuccess(data: await ref.getDownloadURL());
    } on FirebaseException catch (e) {
      return handleFirebaseException<String>(e);
    } catch (e) {
      return defaultDataFailure<String>(e.toString());
    }
  }

  @override
  Future<DataState<String>> uploadImage(image, String path) async {
    try {
      if (image == null) {
        return defaultDataFailure<String>('There is no image');
      }

      String? mimeType;
      Uint8List? imageData;
      if (image is File) {
        mimeType = lookupMimeType(image.path);
      } else if (image is Uint8List) {
        mimeType = lookupMimeType('', headerBytes: image);
        imageData = image;
      } else if (image is String) {
        if (isImageBase64(image)) {
          final encodedData = image.split(',')[1];
          imageData = Uint8List.fromList(base64Decode(encodedData));
          mimeType = image.split(',')[0].split(':')[1].split(';')[0];
        } else if (isImageInWeb(image)) {
          final response = await http.get(Uri.parse(image));
          if (response.statusCode != 200) {
            return defaultDataFailure<String>(S.current.fetchDataFailure);
          }
          mimeType = response.headers['content-type'];
          imageData = response.bodyBytes;
        }
      } else {
        return defaultDataFailure<String>(S.current.unsupportedImageFormat);
      }

      if (!_isImageMimeType(mimeType)) {
        return defaultDataFailure<String>(S.current.invalidImageFileType);
      }

      final ref = _storage.ref(path);

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask =
            ref.putData(imageData!, SettableMetadata(contentType: mimeType));
      } else {
        File? imgFile;
        if (image is! File) {
          imgFile = await ImageUtils.createTmpFile(imageData!, mimeType);
        } else {
          imgFile = image;
        }

        uploadTask =
            ref.putFile(imgFile!, SettableMetadata(contentType: mimeType));
      }

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();

      return DataSuccess(data: downloadUrl);
    } on FirebaseException catch (e) {
      return handleFirebaseException<String>(e);
    } catch (e) {
      return defaultDataFailure<String>(e.toString());
    }
  }

  @override
  Future<DataState<Uint8List?>> getImage(String path) async {
    try {
      final ref = _storage.ref(path);
      final Uint8List? imageData = await ref.getData();

      return DataSuccess(data: imageData);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<ImageFile>>> getFolderImages(String folderPath) async {
    List<ImageFile> images = [];
    try {
      final result = await _storage.ref(folderPath).listAll();
      for (var item in result.items) {
        images.add(ImageFile(
          UniqueKey().toString(),
          name: item.name,
          extension: _getFileExtension(item.name),
          bytes: await item.getData(),
          path: await item.getDownloadURL(),
        ));
      }
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }

    return DataSuccess(data: images);
  }

  bool _isImageMimeType(String? mimeType) {
    return mimeType != null && mimeType.startsWith('image/');
  }

  String _getFileExtension(String? filePath) {
    return filePath == null ? '' : path.extension(filePath).toLowerCase();
  }

  bool isImageInWeb(image) =>
      image is String && (isHttpBasedUrl(image) || image.startsWith('blob'));
}
