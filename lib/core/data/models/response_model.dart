import 'package:equatable/equatable.dart';

abstract class ResponseModel extends Equatable {
  final bool? status;
  final String? message;

  const ResponseModel({
    required this.status,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
