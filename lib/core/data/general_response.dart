import 'package:equatable/equatable.dart';

abstract class GeneralResponse extends Equatable {
  final bool? status;
  final String? message;

  const GeneralResponse({
    required this.status,
    this.message,
  });

  Map<String, dynamic> toJson();

  @override
  bool get stringify => true;
}
