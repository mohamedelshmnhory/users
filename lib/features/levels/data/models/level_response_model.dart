import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/data/general_response.dart';
import 'level.dart';

part 'level_response_model.g.dart';

@JsonSerializable()
class LevelsResponseModel extends GeneralResponse {
  final List<Level>? results;
  String? next;
  String? previous;
  int? count;

  LevelsResponseModel({required super.status, super.message, this.results});

  factory LevelsResponseModel.fromJson(Map<String, dynamic> json) => _$LevelsResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LevelsResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LevelResponseModel extends GeneralResponse {
  final Level? data;

  const LevelResponseModel({required super.status, super.message, this.data});

  factory LevelResponseModel.fromJson(Map<String, dynamic> json) => _$LevelResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LevelResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}
