import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:uuid/uuid.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../cores/utils/image_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../data/models/review.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;
  final TourBloc tourBloc;
  static const basePath = '/reviews';

  ReviewBloc({
    required this.reviewRepository,
    required this.tourBloc,
  }) : super(ReviewInitial()) {
    on<InitializeNewReviewEvent>(_onInitializeNewReview);
    on<GetReviewByIdEvent>(_onGetReviewById);
    on<GetAllTourReviewsEvent>(_onGetAllTourReviews);
    on<CreateReviewEvent>(_onCreateReview);
    on<DeleteReviewEvent>(_onDeleteReviewById);
    on<UpdateReviewFieldEvent>(_onUpdateReviewField);
    on<UploadImageEvent>(_onUploadImageFile);
  }

  void _onInitializeNewReview(InitializeNewReviewEvent event, emit) {
    emit(ReviewLoaded(ReviewEntity(
      reviewId: 'REVIEW-${const Uuid().v4()}',
      userId: event.userId,
      tourId: event.tourId,
      content: '',
      rating: 5,
      createdAt: DateTime.now(),
      images: const [],
    )));
  }

  Future<void> _onGetReviewById(GetReviewByIdEvent event, emit) async {
    try {
      final dataState = await reviewRepository.getReviewById(event.reviewId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(ReviewActionFailure(S.current.dataStateFailure));
      } else {
        emit(ReviewLoaded(dataState.data!.toEntity()));
      }
    } catch (e) {
      log(e.toString());
      emit(ReviewActionFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onGetAllTourReviews(
      GetAllTourReviewsEvent event, Emitter<ReviewState> emit) async {
    await emit.forEach(
      reviewRepository.getAllTourReviews(event.tourId),
      onData: (dataState) {
        if (dataState is DataFailure) {
          log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
          return ReviewActionFailure(S.current.dataStateFailure);
        } else {
          double newRating = _calculateAverageRating(
              dataState.data!.map((review) => review.toEntity()).toList());
          tourBloc.add(UpdateTourRatingEvent(event.tourId, newRating));
          return ListOfReviewsLoaded(
              dataState.data?.map((review) => review.toEntity()).toList() ??
                  []);
        }
      },
      onError: (error, stackTrace) {
        log(error.toString());
        return ReviewActionFailure(error.toString());
      },
    );
  }

  Future<void> _onCreateReview(
      CreateReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      List<String> imgUrls = [];

      for (var img in event.images) {
        String? imgUrl = await ImageUtils.uploadImage(img,
            '$basePath/${event.review.tourId}/${event.review.userId}/${img.name}');

        if (imgUrl?.isNotEmpty ?? false) {
          imgUrls.add(imgUrl!);
        } else {
          emit(ReviewActionFailure(S.current.addImageFailure(img.name)));
        }
      }

      final dataState = await reviewRepository.createReview(
          Review.fromEntity(event.review.copyWith(images: imgUrls)));

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(ReviewActionFailure(S.current.dataStateFailure));
      } else {
        emit(ReviewActionSuccess(dataState.data!.toEntity()));
      }
    } catch (e) {
      log(e.toString());
      emit(ReviewActionFailure(S.current.dataStateFailure));
    }
  }

  Future<void> _onDeleteReviewById(DeleteReviewEvent event, emit) async {
    try {
      final dataState = await reviewRepository.deleteReviewById(event.reviewId);

      if (dataState is DataFailure) {
        log(dataState.error?.message ?? 'ERROR OCCURRED: ${dataState.error}');
        emit(ReviewActionFailure(S.current.dataStateFailure));
      } else {
        emit(ReviewDeleted());
      }
    } catch (e) {
      log(e.toString());
      emit(ReviewActionFailure(S.current.dataStateFailure));
    }
  }

  void _onUpdateReviewField(UpdateReviewFieldEvent event, emit) {
    if (state is ReviewLoaded) {
      final ReviewEntity review = (state as ReviewLoaded).review;
      final ReviewEntity updatedReview =
          _updateReviewField(review, event.fieldName, event.value);
      emit(ReviewLoaded(updatedReview));
    }
  }

  ReviewEntity _updateReviewField(
      ReviewEntity review, String fieldName, dynamic value) {
    switch (fieldName) {
      case ReviewEntity.ratingFieldName:
        return review.copyWith(rating: value as double);
      case ReviewEntity.contentFieldName:
        return review.copyWith(content: value as String);
      default:
        return review;
    }
  }

  double _calculateAverageRating(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) return 0;
    final totalRating = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return totalRating / reviews.length;
  }

  void _onUploadImageFile(UploadImageEvent event, emit) {
    emit(ReviewImageLoaded(event.images));
  }
}
