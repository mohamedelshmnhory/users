// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersRequestParams _$UsersRequestParamsFromJson(Map<String, dynamic> json) =>
    UsersRequestParams(
      perPage: json['perPage'] as num?,
      page: json['page'] as num?,
      username: json['username'] as String?,
      fullname: json['fullname'] as String?,
      description: json['description'] as String?,
      job_id: json['job_id'] as num?,
      level_id: json['level_id'] as num?,
      more: json['more'] as bool?,
    );

Map<String, dynamic> _$UsersRequestParamsToJson(UsersRequestParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('perPage', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('job_id', instance.job_id);
  writeNotNull('level_id', instance.level_id);
  writeNotNull('username', instance.username);
  writeNotNull('fullname', instance.fullname);
  writeNotNull('description', instance.description);
  writeNotNull('more', instance.more);
  return val;
}
