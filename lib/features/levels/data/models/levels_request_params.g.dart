// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'levels_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelsRequestParams _$LevelsRequestParamsFromJson(Map<String, dynamic> json) =>
    LevelsRequestParams(
      per_page: json['per_page'] as num?,
      page: json['page'] as num?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$LevelsRequestParamsToJson(LevelsRequestParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.per_page);
  writeNotNull('page', instance.page);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  return val;
}
