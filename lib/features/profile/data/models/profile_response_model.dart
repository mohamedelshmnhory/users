

import '../../../../core/data/api_manager.dart';
import '../../../../core/data/general_response.dart';
import '../../../authentication/register/data/model/user.dart';

class ProfileResponseModel extends GeneralResponse implements ResponseModel {
  final User data;

  const ProfileResponseModel({
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

  factory ProfileResponseModel.fromJson(Map<String, dynamic> map) {
    return ProfileResponseModel(
      status: map['status'],
      message: map['message'],
      data: User.fromJson(map['data']),
    );
  }

  @override
  List<Object> get props => [ data];

  @override
  bool get stringify => true;
}
