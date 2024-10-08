part of 'tour_bloc.dart';

sealed class TourState extends Equatable {
  const TourState();

  @override
  List<Object> get props => [];
}

final class TourActionFailed extends TourState {
  final String message;
  const TourActionFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class TourActionSucceed extends TourState {
  final TourEntity tour;
  const TourActionSucceed(this.tour);

  @override
  List<Object> get props => [tour];
}

final class TourLoaded extends TourState {
  final TourEntity tour;
  const TourLoaded(this.tour);

  @override
  List<Object> get props => [tour];
}

final class ListOfToursLoaded extends TourState {
  final List<TourEntity> tours;
  const ListOfToursLoaded(this.tours);

  @override
  List<Object> get props => [tours];
}

final class TourActionLoading extends TourState {}
