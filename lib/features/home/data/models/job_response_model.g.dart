// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsResponseModel _$JobsResponseModelFromJson(Map<String, dynamic> json) =>
    JobsResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..next = json['next'] as String?
      ..previous = json['previous'] as String?
      ..count = json['count'] as int?;

Map<String, dynamic> _$JobsResponseModelToJson(JobsResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'results': instance.results,
      'next': instance.next,
      'previous': instance.previous,
      'count': instance.count,
    };

JobResponseModel _$JobResponseModelFromJson(Map<String, dynamic> json) =>
    JobResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Job.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobResponseModelToJson(JobResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
