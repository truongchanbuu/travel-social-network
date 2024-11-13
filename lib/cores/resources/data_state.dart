import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

final class DataSuccess<T> extends DataState<T> {
  const DataSuccess({super.data});
}

final class DataFailure<T> extends DataState<T> {
  const DataFailure({super.error});
}

final class DataInitial<T> extends DataState<T> {
  const DataInitial();
}

DataFailure<T> handleFirebaseException<T>(
  FirebaseException e, {
  DioExceptionType? type,
}) {
  debugPrint('Operation failed: ${e.message}');
  return DataFailure<T>(
    error: DioException(
      requestOptions: RequestOptions(),
      error: e.code,
      message: e.message,
      stackTrace: e.stackTrace,
      type: type ?? DioExceptionType.cancel,
    ),
  );
}

DataFailure<T> defaultDataFailure<T>(String errorMessage,
    {RequestOptions? reqOpts}) {
  return DataFailure<T>(
    error: DioException(
      message: 'There is something happened $errorMessage',
      requestOptions: reqOpts ?? RequestOptions(),
      error: errorMessage,
    ),
  );
}
