import '../../../../cores/resources/data_state.dart';

abstract interface class ImageRepository {
  String getFullPath(String filename);
  Future<DataState<String>> uploadImage(dynamic image, String name);
  Future<DataState<dynamic>> downloadImage(String name);
  Future<DataState<dynamic>> deleteImage(String name);
  Future<DataState<String>> getImageUrl(String name);
}
