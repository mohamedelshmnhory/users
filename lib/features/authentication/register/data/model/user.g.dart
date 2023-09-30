// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      old_password: json['old_password'] as String?,
      new_password: json['new_password'] as String?,
      code: json['code'] as String?,
      fcm_token: json['fcm_token'] as String?,
      token: json['token'] as String?,
      data: json['data'],
      avatar: json['avatar'],
      method: json['_method'] as String?,
      social: $enumDecodeNullable(_$SocialLoginEnumMap, json['social']),
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: json['level'] == null
          ? null
          : Level.fromJson(json['level'] as Map<String, dynamic>),
      jobs_id:
          (json['jobs_id'] as List<dynamic>?)?.map((e) => e as num).toList(),
      level_id: json['level_id'] as num?,
    )
      ..id = json['id'] as num?
      ..is_superuser = json['is_superuser'] as bool?
      ..is_favourite = json['is_favourite'] as bool?;

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('username', instance.username);
  writeNotNull('fullname', instance.fullname);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('password', instance.password);
  writeNotNull('old_password', instance.old_password);
  writeNotNull('new_password', instance.new_password);
  writeNotNull('is_superuser', instance.is_superuser);
  writeNotNull('code', instance.code);
  writeNotNull('fcm_token', instance.fcm_token);
  writeNotNull('token', instance.token);
  writeNotNull('data', instance.data);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('_method', instance.method);
  writeNotNull('social', _$SocialLoginEnumMap[instance.social]);
  writeNotNull('jobs', instance.jobs);
  writeNotNull('jobs_id', instance.jobs_id);
  writeNotNull('level', instance.level);
  writeNotNull('level_id', instance.level_id);
  writeNotNull('is_favourite', instance.is_favourite);
  return val;
}

const _$SocialLoginEnumMap = {
  SocialLogin.google: 'google',
  SocialLogin.facebook: 'facebook',
  SocialLogin.twitter: 'twitter',
};
