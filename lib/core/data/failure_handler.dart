import 'dart:io';

import 'package:dio/dio.dart';

import 'api_manager.dart';

class FailureHandler {
  FailureHandler();
  final StatusChecker _statusChecker = StatusChecker();

  Failure handle({Request? request, dynamic exception, Response? response}) {
    final failureInfo = FailureInfo(request: request, exception: exception, response: response);
    Failure? failure;
    if (exception is ErrorException) {
      failure = ErrorFailure(
        errorStatus: _statusChecker.getErrorState(exception.statusCode),
        error: exception.error,
      );
    } else if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.badCertificate:
        case DioExceptionType.connectionError:
        case DioExceptionType.receiveTimeout:
          failure = ConnectionFailure();
          break;
        case DioExceptionType.cancel:
          failure = RequestCanceledFailure();
          break;
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          {
            final socketException = exception.message?.contains('SocketException') ?? false;
            final getRequest = request?.method == 'GET';
            final httpException =
                (exception.message?.contains('HttpException') ?? false) || (exception.message?.contains('Connection') ?? false);

            if (socketException || (httpException && getRequest)) {
              failure = ConnectionFailure();
            }
            failure = UnkownFailure(failureInfo);
          }
      }
    } else if (exception is ServerException) {
      final status = _statusChecker(exception.response?.statusCode);
      switch (status) {
        case HTTPCodes.invalidToken:
          failure = SessionEndedFailure();
          break;
        case HTTPCodes.serviceNotAvailable:
          failure = ServiceNotAvailableFailure(failureInfo);
          break;
        case HTTPCodes.unknown:
          failure = UnkownFailure(failureInfo);
          break;
        default:
          break;
      }
    } else if (exception is SocketException) {
      failure = ConnectionFailure();
    } else if (exception is FormatException) {
      failure = ServiceNotAvailableFailure(failureInfo);
    } else if (exception is ValidationException) {
      failure = ValidationFailure(exception.value, exception.value);
    } else if (exception is TypeError) {
      failure = TypeFailure(failureInfo);
    }
    if (failure is ReportableFailure) {
      // Crashlytics.instance.recordError(failure);
    }
    return failure ?? UnkownFailure(failureInfo);
  }
}
