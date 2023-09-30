// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelsResponseModel _$LevelsResponseModelFromJson(Map<String, dynamic> json) =>
    LevelsResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Level.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..next = json['next'] as String?
      ..previous = json['previous'] as String?
      ..count = json['count'] as int?;

Map<String, dynamic> _$LevelsResponseModelToJson(
        LevelsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'results': instance.results,
      'next': instance.next,
      'previous': instance.previous,
      'count': instance.count,
    };

LevelResponseModel _$LevelResponseModelFromJson(Map<String, dynamic> json) =>
    LevelResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Level.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LevelResponseModelToJson(LevelResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
