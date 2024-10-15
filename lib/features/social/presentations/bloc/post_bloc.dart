import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:travel_social_network/cores/resources/data_state.dart';
import 'package:travel_social_network/features/social/data/models/post.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/utils/image_utils.dart';
import '../../../../generated/l10n.dart';
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
  }

  void _onContentUpdated(UpdateContentEvent event, Emitter<PostState> emit) {
    emit(ContentUpdated(content: event.content.trim(), images: event.images));
  }

  Future<void> _onSavePost(SavePostEvent event, Emitter<PostState> emit) async {
    if (state is ContentUpdated) {
      try {
        List<String> imageUrls = [];
        Post post = Post(
          postId: 'POST-${const Uuid().v4()}',
          content: state.content,
          images: imageUrls,
          userId: event.userId,
        );

        for (var img in state.images) {
          String? imgUrl =
              await ImageUtils.uploadImage(img, '$basePath/${post.postId}');

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
          emit(PostActionSucceed(dataState.data!));
        }
      } catch (e) {
        log(e.toString());
        emit(PostActionFailed(S.current.dataStateFailure));
      }
    }
  }

  Future<void> _onGetAllPosts(
      GetPostsEvent event, Emitter<PostState> emit) async {
    await emit.forEach(
      postRepository.getPosts(),
      onData: (dataState) {
        if (dataState is DataFailure) {
          log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
          return PostActionFailed(S.current.dataStateFailure);
        } else {
          return ListOfPostReceived(
            dataState.data?.map((post) => post.toEntity()).toList() ?? [],
          );
        }
      },
      onError: (error, stackTrace) {
        log(error.toString());
        return PostActionFailed(error.toString());
      },
    );
  }
}
