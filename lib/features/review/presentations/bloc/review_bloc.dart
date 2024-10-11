import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/domain/repositories/image_repository.dart';
import '../../data/models/review.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;
  final ImageRepository imageRepository;
  static const basePath = '/reviews';

  ReviewBloc({required this.reviewRepository, required this.imageRepository})
      : super(ReviewInitial()) {
    on<GetReviewByIdEvent>(_onGetReviewById);
    on<GetAllTourReviewsEvent>(_onGetAllTourReviews);
    on<CreateReviewEvent>(_onCreateReview);
  }

  Future<void> _onGetReviewById(GetReviewByIdEvent event, emit) async {
    try {
      final dataState = await reviewRepository.getReviewById(event.reviewId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(ReviewActionFailure(S.current.dataStateFailure));
      } else if (dataState is DataSuccess) {
        emit(ReviewActionSuccess(dataState.data!.toEntity()));
      } else {
        emit(ReviewActionLoading());
      }
    } catch (e) {
      log(e.toString());
      emit(ReviewActionFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onGetAllTourReviews(GetAllTourReviewsEvent event, emit) async {
    try {
      final dataState = await reviewRepository.getAllTourReviews(event.tourId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(ReviewActionFailure(S.current.dataStateFailure));
      } else if (dataState is DataSuccess) {
        emit(ListOfReviewsLoaded(
            dataState.data!.map((review) => review.toEntity()).toList()));
      } else {
        emit(ReviewActionLoading());
      }
    } catch (e) {
      log(e.toString());
      emit(ReviewActionFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onCreateReview(CreateReviewEvent event, emit) async {
    try {
      List<String> imgUrls = [];

      for (var img in event.images) {
        String? imgUrl = await _onUploadImage(
            img, '$basePath/${event.tourId}/${event.userId}/${img.name}');

        if (imgUrl?.isNotEmpty ?? false) {
          imgUrls.add(imgUrl!);
        } else {
          emit(ReviewActionFailure(S.current.addImageFailure(img.name)));
        }
      }

      ReviewEntity review = ReviewEntity(
        reviewId: 'REVIEW-${const Uuid().v4()}',
        userId: event.userId,
        tourId: event.tourId,
        content: event.content,
        rating: event.rating,
        createdAt: DateTime.now(),
        images: imgUrls,
      );

      final dataState =
          await reviewRepository.createReview(Review.fromEntity(review));

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(ReviewActionFailure(S.current.dataStateFailure));
      } else if (dataState is DataSuccess) {
        emit(ReviewActionSuccess(dataState.data!.toEntity()));
      } else {
        emit(ReviewActionLoading());
      }
    } catch (e) {
      log(e.toString());
      emit(ReviewActionFailure(S.current.dataStateFailure));
    }
  }

  Future<String?> _onUploadImage(ImageFile image, String path) async {
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
}
