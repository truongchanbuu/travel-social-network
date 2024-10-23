import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/image_utils.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/post.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  static const String basePath = 'posts';

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<UpdateContentEvent>(_onContentUpdated);
    on<SavePostEvent>(_onSavePost);
    on<GetPostsEvent>(_onGetAllPosts);
    on<GetPostByIdEvent>(_onGetPostById);
    on<DeletePostById>(_onDeletePost);
    on<UpdatePostEvent>(_onUpdatePost);
    on<LikePostEvent>(_onLikePost);
    on<EditPostProgressEvent>(_onEditingPostProcess);
  }

  void _onContentUpdated(UpdateContentEvent event, Emitter<PostState> emit) {
    emit(ContentUpdated(content: event.content.trim(), images: event.images));
  }

  Future<void> _onSavePost(SavePostEvent event, Emitter<PostState> emit) async {
    if (state is ContentUpdated) {
      String content = state.content;
      List<ImageFile> images = state.images;
      emit(PostActionLoading());
      try {
        List<String> imageUrls = [];
        Post post;

        if (event.post == null) {
          post = Post(
            postId: 'POST-${const Uuid().v4()}',
            likedUsers: const [],
            content: content,
            images: imageUrls,
            userId: event.userId,
            createdAt: DateTime.now(),
            sharedBy: const [],
            refPostId: event.sharedPostId,
          );
        } else {
          post = Post.fromEntity(event.post!.copyWith(
            content: content,
            updatedAt: DateTime.now(),
          ));
        }

        for (var img in images) {
          String? imgUrl = await ImageUtils.uploadImage(
              img, '$basePath/${post.postId}/${img.name}');

          if (imgUrl?.isNotEmpty ?? false) {
            imageUrls.add(imgUrl!);
          }
        }

        post = Post.fromEntity(post.copyWith(images: imageUrls));
        final dataState = await postRepository.createPost(post);

        if (dataState is DataFailure) {
          log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
          emit(PostActionFailed(S.current.dataStateFailure));
        } else {
          emit(PostActionSucceed(dataState.data!.toEntity()));
          if (event.sharedPostId != null) {
            add(UpdatePostEvent(
              event.sharedPostId!,
              {
                PostEntity.sharedByFieldName: [post.postId]
              },
            ));
          }
        }
      } catch (e) {
        log(e.toString());
        emit(PostActionFailed(S.current.dataStateFailure));
      }
    }
  }

  Future<void> _onGetAllPosts(
      GetPostsEvent event, Emitter<PostState> emit) async {
    emit(PostActionLoading());
    try {
      final dataState = await postRepository.getPosts();
      if (dataState is DataFailure) {
        log(dataState.error?.message ??
            'Get all posts failed: ${dataState.error}');
        emit(PostActionFailed(S.current.dataStateFailure));
      } else {
        emit(ListOfPostReceived(
          dataState.data?.map((post) => post.toEntity()).toList() ?? [],
        ));
      }
    } catch (e) {
      log('Get all posts failed: $e');
      emit(PostActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onDeletePost(
      DeletePostById event, Emitter<PostState> emit) async {
    try {
      final dataState = await postRepository.deletePostById(event.postId);
      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PostActionFailed(S.current.dataStateFailure));
      } else {
        emit(PostDeleted());
      }
    } catch (e) {
      log(e.toString());
      emit(PostActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onUpdatePost(
      UpdatePostEvent event, Emitter<PostState> emit) async {
    try {
      final dataState =
          await postRepository.updatePost(event.postId, event.data);
      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PostActionFailed(S.current.dataStateFailure));
      } else {
        emit(PostActionSucceed(dataState.data!));
      }
    } catch (e) {
      log(e.toString());
      emit(PostActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onLikePost(LikePostEvent event, Emitter<PostState> emit) async {
    try {
      final dataState =
          await postRepository.updatePost(event.postId, event.data);
      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PostActionFailed(S.current.dataStateFailure));
      } else {
        emit(PostActionSucceed(dataState.data!));
      }
    } catch (e) {
      log(e.toString());
      emit(PostActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onGetPostById(
      GetPostByIdEvent event, Emitter<PostState> emit) async {
    emit(PostActionLoading());
    try {
      final dataState = await postRepository.getPostById(event.postId);
      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PostActionFailed(S.current.dataStateFailure));
      } else {
        PostEntity post = dataState.data!.toEntity();
        emit(PostReceived(post));
      }
    } catch (e) {
      log(e.toString());
      emit(PostActionFailed(S.current.dataStateFailure));
    }
  }

  Future<void> _onEditingPostProcess(
      EditPostProgressEvent event, Emitter<PostState> emit) async {
    emit(PostActionLoading());
    try {
      final dataState = await postRepository.getPostById(event.postId);
      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(PostActionFailed(S.current.dataStateFailure));
      } else {
        PostEntity post = dataState.data!.toEntity();
        emit(PostReceived(post));

        add(UpdateContentEvent(
            content: post.content,
            images: ImageUtils.converImageUrlToImageFile(post.images)));
      }
    } catch (e) {
      log(e.toString());
      emit(PostActionFailed(S.current.dataStateFailure));
    }
  }
}
