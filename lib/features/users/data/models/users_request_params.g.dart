// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersRequestParams _$UsersRequestParamsFromJson(
        Map<String, dynamic> json) =>
    UsersRequestParams(
      perPage: json['perPage'] as num?,
      page: json['page'] as num?,
    );

Map<String, dynamic> _$UsersRequestParamsToJson(
    UsersRequestParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('perPage', instance.perPage);
  writeNotNull('page', instance.page);
  return val;
}
