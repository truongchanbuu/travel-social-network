part of 'tour_bloc.dart';

sealed class TourEvent extends Equatable {
  const TourEvent();

  @override
  List<Object> get props => [];
}

final class UpdateTourFieldEvent extends TourEvent {
  final String fieldName;
  final dynamic value;

  const UpdateTourFieldEvent(this.fieldName, this.value);

  @override
  List<Object> get props => [fieldName, value];
}
