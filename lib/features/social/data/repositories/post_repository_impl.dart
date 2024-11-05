import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/field_array_update_type.dart';
import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post.dart';

class PostRepositoryImpl implements PostRepository {
  final postCollection = firestore.collection('posts');

  @override
  Future<DataState<Post>> createPost(Post post) async {
    try {
      await postCollection.doc(post.postId).set(post.toJson());
      return DataSuccess(data: post);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<List<Post>>> getPosts() async {
    try {
      List<Post> posts = [];
      final docRef = await postCollection
          .orderBy(PostEntity.createdAtFieldName, descending: true)
          .get();
      final docSnaps = docRef.docs;

      for (var doc in docSnaps) {
        final Post post = Post.fromJson(doc.data());
        posts.add(post);
      }

      return DataSuccess(data: posts);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<void>> deletePostById(String postId) async {
    try {
      final docRef = await postCollection.doc(postId).get();

      final Post currentPost = Post.fromJson(docRef.data()!);
      if (currentPost.sharedBy.isNotEmpty) {
        for (var childPostId in currentPost.sharedBy) {
          updatePost(childPostId, {PostEntity.refPostIdFieldName: ""});
        }
      }

      if (currentPost.refPostId?.isNotEmpty ?? false) {
        updatePost(
          currentPost.refPostId!,
          {
            PostEntity.sharedByFieldName: [postId]
          },
          FieldArrayUpdateTypes.remove,
        );
      }

      await postCollection.doc(postId).delete();
      return const DataSuccess();
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Post>> getPostById(String postId) async {
    try {
      final docRef = postCollection.doc(postId);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        return defaultDataFailure(S.current.notFound);
      }

      final post = Post.fromJson(docSnap.data()!);
      return DataSuccess(data: post);
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }

  @override
  Future<DataState<Post>> updatePost(String postId, Map<String, dynamic> data,
      [FieldArrayUpdateTypes updateType = FieldArrayUpdateTypes.union]) async {
    try {
      final docRef = postCollection.doc(postId);

      final Map<String, dynamic> updateData = {};
      data.forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          if (updateType == FieldArrayUpdateTypes.union) {
            updateData[key] = FieldValue.arrayUnion(value);
          } else if (updateType == FieldArrayUpdateTypes.remove) {
            updateData[key] = FieldValue.arrayRemove(value);
          }
        } else {
          updateData[key] = value;
        }
      });

      await docRef.update(updateData);

      final docSnap = await docRef.get();

      if (docSnap.exists) {
        return DataSuccess(data: Post.fromJson(docSnap.data()!));
      } else {
        return defaultDataFailure(S.current.notFound);
      }
    } on FirebaseException catch (e) {
      return handleFirebaseException(e);
    } catch (e) {
      return defaultDataFailure(e.toString());
    }
  }
}
