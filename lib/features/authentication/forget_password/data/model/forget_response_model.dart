

import '../../../../../core/data/api_manager.dart';
import '../../../../../core/data/general_response.dart';

class ForgetResponseModel extends GeneralResponse implements ResponseModel {
  final String? data;

  const ForgetResponseModel({required super.status, super.message, required this.data});

  @override
  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };

  factory ForgetResponseModel.fromMap(Map<String, dynamic> map) {
    return ForgetResponseModel(
      status: map['status'],
      message: map['message'],
      data: map['data'],
    );
  }

  @override
  List<Object> get props => [status ?? true];

  @override
  bool get stringify => true;
}
