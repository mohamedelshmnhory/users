import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../services/app_logger.dart';
import 'exceptions.dart';
import 'failure_handler.dart';
import 'failures.dart';
import 'models/message_response.dart';
import 'models/response_model.dart';
import 'request/base_request.dart';
import 'status_checker.dart';

export 'exceptions.dart';
export 'failure_handler.dart';
export 'failures.dart';
export 'models/id_request_model.dart';
export 'models/message_response.dart';
export 'models/request_model.dart';
export 'models/response_model.dart';
export 'request/base_request.dart';
export 'status_checker.dart';

@injectable
class APIsManager {
  APIsManager() {
    if (shouldLog) {
      // _dio.interceptors.addAll(interceptors);
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }

  final StatusChecker _statusChecker = StatusChecker();
  final FailureHandler _failureHandler = FailureHandler();
  final Dio _dio = Dio();
  // final List<Interceptor> interceptors;
  // static const UrlencodedType = 'application/x-www-form-urlencoded';
  // static const JsonType = 'application/json';
  // static const Accept = 'Accept';
  Future<Either<Failure, R>> send<R, ER extends ResponseModel>({
    required Request request,
    required R Function(Map<String, dynamic> map)? responseFromMap,
    ER Function(Map<String, dynamic> map)? errorResponseFromMap,
  }) async {
    // _dio.options.headers[Accept] = JsonType;
    Response<dynamic>? response;
    try {
      response = await _dio.request(
        request.url,
        data: await request.data,
        queryParameters: request.queryParameters,
        cancelToken: request.cancelToken,
        onSendProgress: request.requestModel.progressListener?.onSendProgress,
        onReceiveProgress: request.requestModel.progressListener?.onReceiveProgress,
        options: Options(
          headers: request.headers,
          method: request.method,
          // contentType: 'application/json',
          // contentType: UrlencodedType,
        ),
      );
      //todo
      // dio2curl(response.requestOptions);
      var resp = response.data;

      if (resp is! Map<String, dynamic>) {
        dynamic mapResponse;
        try {
          mapResponse = json.decode(response.data);
        } catch (e) {
          e.toString();
        }
        if (mapResponse != null && mapResponse is Map) {
          resp = mapResponse;
        } else {
          resp = {'response': resp};
        }
      }
      return Right(responseFromMap!(resp));
    } on DioException catch (error) {
      // dio2curl(error.response?.requestOptions);
      if (error.type == DioExceptionType.badResponse) {
        if (error.response?.statusCode != null && _statusChecker(error.response!.statusCode) == HTTPCodes.error) {
          try {
            final Map<String, dynamic> errorData = {'errors': error.response!.data};

            final exception = ErrorException(error.response!.statusCode!,
                errorResponseFromMap != null ? errorResponseFromMap(errorData) : MessageResponse.fromMap(errorData)
                // : MessageResponse.fromMap(errorData,code:error.response!.statusCode.toString()),
                );
            return Left(
              _failureHandler.handle(
                request: request,
                exception: exception,
                response: error.response,
              ),
            );
          } catch (exception) {
            return Left(
              _failureHandler.handle(
                request: request,
                exception: exception,
                response: response,
              ),
            );
          }
        } else {
          final exception = ServerException(error.response);

          return Left(
            _failureHandler.handle(
              request: request,
              exception: exception,
              response: error.response,
            ),
          );
        }
      }
      return Left(
        _failureHandler.handle(
          request: request,
          exception: error,
          response: error.response,
        ),
      );
    }
    // catch (exception) {
    //   dio2curl(response?.requestOptions);
    //   return Left(
    //     _failureHandler.handle(
    //       request: request,
    //       exception: exception,
    //       response: response,
    //     ),
    //   );
    // }
  }
}
