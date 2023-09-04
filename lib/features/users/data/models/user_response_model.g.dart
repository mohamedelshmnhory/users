// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersResponseModel _$UsersResponseModelFromJson(
        Map<String, dynamic> json) =>
    UsersResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..page = json['page'] as int?
      ..per_page = json['per_page'] as int?
      ..total_pages = json['total_pages'] as int?
      ..total = json['total'] as int?;

Map<String, dynamic> _$UsersResponseModelToJson(
        UsersResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'page': instance.page,
      'per_page': instance.per_page,
      'total_pages': instance.total_pages,
      'total': instance.total,
    };

UserResponseModel _$UserResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseModelToJson(
        UserResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as num?,
      email: json['email'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('first_name', instance.first_name);
  writeNotNull('last_name', instance.last_name);
  writeNotNull('avatar', instance.avatar);
  return val;
}
