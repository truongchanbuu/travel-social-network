import '../../../../cores/resources/data_state.dart';
import '../../data/models/post.dart';

abstract interface class PostRepository {
  Future<DataState<Post>> createPost(Post post);
  Future<DataState<List<Post>>> getPosts();
  Future<DataState<Post>> getPostById(String postId);
  Future<DataState<void>> deletePostById(String postId);
  Future<DataState<Post>> updatePost(String postId, Map<String, dynamic> data);
}
