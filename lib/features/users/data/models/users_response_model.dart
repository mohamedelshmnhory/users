import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/data/general_response.dart';
import '../../../authentication/register/data/model/user.dart';

part 'users_response_model.g.dart';

@JsonSerializable()
class UsersResponseModel extends GeneralResponse {
  final List<User>? results;
  String? next;
  String? previous;
  int? count;

  UsersResponseModel({required super.status, super.message, this.results});

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) => _$UsersResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UsersResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class UserResponseModel extends GeneralResponse {
  final User? data;

  const UserResponseModel({required super.status, super.message, this.data});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}
