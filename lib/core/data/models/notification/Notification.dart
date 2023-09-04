import 'package:json_annotation/json_annotation.dart';



part 'Notification.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationModel {
  dynamic id;
  String? type;
  String? title;
  String? body;
  String? description;
  String? link;
  String? created_at;
  String? updated_at;

  NotificationModel({this.id, this.type, this.title, this.body, this.description, this.link, this.created_at, this.updated_at});

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
