// ignore_for_file: must_be_immutable

import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/data/models/request_model.dart';
import '../../../../home/data/models/job.dart';
import '../../../../levels/data/models/level.dart';

part 'user.g.dart';

@JsonSerializable(includeIfNull: false)
class User extends RequestModel {
  num? id;
  String? username;
  String? fullname;
  String? email;
  String? phone;
  String? password;
  String? old_password;
  String? new_password;
  bool? is_superuser;
  String? code;
  String? fcm_token;
  String? token;
  dynamic data;
  dynamic avatar;
  @JsonKey(name: '_method')
  String? method;
  SocialLogin? social;
  List<Job>? jobs;
  List<num>? jobs_id;
  Level? level;
  num? level_id;
  bool? is_favourite;

  User({
    this.username,
    this.fullname,
    this.email,
    this.phone,
    this.password,
    this.old_password,
    this.new_password,
    this.code,
    this.fcm_token,
    this.token,
    this.data,
    this.avatar,
    this.method,
    this.social,
    this.jobs,
    this.level,
    this.jobs_id,
    this.level_id,
  }) : super(null);

  @override
  List<Object?> get props => [id];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum SocialLogin { google, facebook, twitter }
