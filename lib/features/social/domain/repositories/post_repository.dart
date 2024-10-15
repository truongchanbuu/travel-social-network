import '../../../../cores/resources/data_state.dart';
import '../../data/models/post.dart';

abstract interface class PostRepository {
  Future<DataState<Post>> createPost(Post post);
  Stream<DataState<List<Post>>> getPosts();
}
