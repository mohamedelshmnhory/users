// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'],
      type: json['type'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      description: json['description'] as String?,
      link: json['link'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('type', instance.type);
  writeNotNull('title', instance.title);
  writeNotNull('body', instance.body);
  writeNotNull('description', instance.description);
  writeNotNull('link', instance.link);
  writeNotNull('created_at', instance.created_at);
  writeNotNull('updated_at', instance.updated_at);
  return val;
}
