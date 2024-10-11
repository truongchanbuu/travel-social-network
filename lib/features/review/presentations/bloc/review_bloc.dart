import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/resources/data_state.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;
  ReviewBloc(this.reviewRepository) : super(ReviewInitial()) {
    on<GetReviewByIdEvent>(_onGetReviewById);
    on<GetAllTourReviewsEvent>(_onGetAllTourReviews);
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
}
