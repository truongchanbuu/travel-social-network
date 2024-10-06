part of 'tour_bloc.dart';

sealed class TourState extends Equatable {
  const TourState();
  
  @override
  List<Object> get props => [];
}

final class TourInitial extends TourState {}
