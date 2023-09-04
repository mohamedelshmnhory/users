import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/data/general_response.dart';
import '../../../../core/data/models/request_model.dart';
import '../../../../core/data/models/response_model.dart';

part 'user_response_model.g.dart';

@JsonSerializable()
class UsersResponseModel extends GeneralResponse implements ResponseModel {
  final List<UserModel>? data;
  int? page;
  int? per_page;
  int? total_pages;
  int? total;

  UsersResponseModel({required super.status, super.message, this.data});

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) => _$UsersResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UsersResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class UserResponseModel extends GeneralResponse implements ResponseModel {
  final UserModel? data;

  const UserResponseModel({required super.status, super.message, this.data});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable(includeIfNull: false)
class UserModel extends RequestModel {
  final num? id;
  final String? email;
  final String? first_name;
  final String? last_name;
  final String? avatar;

  UserModel({this.id, this.email, this.first_name, this.last_name, this.avatar}) : super(null);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [id, email];
}
