import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  TourBloc() : super(TourInitial()) {
    on<TourEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
