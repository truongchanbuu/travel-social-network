import '../../../../cores/resources/data_state.dart';

abstract interface class ImageRepository {
  Future<DataState<String>> uploadImage(dynamic image, String path);
  Future<DataState<dynamic>> downloadImage(String path);
  Future<DataState<dynamic>> deleteImage(String path);
  Future<DataState<String>> getImageUrl(String path);
}
