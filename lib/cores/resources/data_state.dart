abstract class DataState<T> {
  final T? data;
  final Exception? error;

  const DataState({this.data, this.error});
}

final class DataSuccess<T> extends DataState {
  const DataSuccess({super.data});
}

final class DataFailure<T> extends DataState {
  const DataFailure({super.error});
}

final class DataInitial<T> extends DataState<T> {
  const DataInitial();
}
