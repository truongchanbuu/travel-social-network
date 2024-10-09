import 'dart:typed_data';

import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/resources/data_state.dart';

abstract interface class ImageRepository {
  Future<DataState<String>> uploadImage(dynamic image, String path);
  Future<DataState<dynamic>> deleteImage(String path);
  Future<DataState<String>> getImageUrl(String path);
  Future<DataState<Uint8List?>> getImage(String path);
  Future<DataState<List<ImageFile>>> getFolderImages(String folderPath);
}
