import 'package:equatable/equatable.dart';

abstract class ResponseModel extends Equatable {
  final bool? status;
  final String? message;
  final Map<String, dynamic>? errors;

  const ResponseModel({required this.status, this.message, this.errors});

  @override
  List<Object?> get props => [status, message, errors];

  String convertErrorsToString() {
    String errorMessage = message?.isNotEmpty == true ? '$message\n' : '';

    errors?.forEach((field, messages) {
      if (messages is List) {
        for (var message in messages) {
          errorMessage += '$field : $message\n';
        }
      } else {
        errorMessage += '$field : $messages\n';
      }
    });

    return errorMessage;
  }
}
