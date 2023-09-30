

import '../../../../../core/data/api_manager.dart';
import '../../../../../core/data/general_response.dart';
import '../../../register/data/model/login_model.dart';

class LoginResponseModel extends GeneralResponse implements ResponseModel {
  final LoginModel data;

  const LoginResponseModel({
    required super.status,
    super.message,
    required this.data,
  });

  @override
  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      status: map['status'],
      message: map['message'],
      data: LoginModel.fromJson(map['data']),
    );
  }

  @override
  List<Object> get props => [status ?? true, data];

  @override
  bool get stringify => true;
}
