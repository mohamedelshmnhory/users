import 'package:equatable/equatable.dart';

abstract class GeneralResponse extends Equatable {
  final bool? status;
  final String? message;
  final Map<String, dynamic>? errors;

  const GeneralResponse({
    required this.status,
    this.message,
    this.errors,
  });

  Map<String, dynamic> toJson();

  @override
  bool get stringify => true;

  String convertErrorsToString() {
    String errorMessage = message?.isNotEmpty == true ? '$message\n' : '';

    errors?.forEach((field, messages) {
      for (var message in messages) {
        errorMessage += '$field : $message\n';
      }
    });

    return errorMessage;
  }
}
