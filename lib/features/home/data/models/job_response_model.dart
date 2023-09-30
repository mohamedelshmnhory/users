import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/data/general_response.dart';
import 'job.dart';

part 'job_response_model.g.dart';

@JsonSerializable()
class JobsResponseModel extends GeneralResponse {
  final List<Job>? results;
  String? next;
  String? previous;
  int? count;

  JobsResponseModel({required super.status, super.message, this.results});

  factory JobsResponseModel.fromJson(Map<String, dynamic> json) => _$JobsResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JobsResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class JobResponseModel extends GeneralResponse {
  final Job? data;

  const JobResponseModel({required super.status, super.message, this.data});

  factory JobResponseModel.fromJson(Map<String, dynamic> json) => _$JobResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JobResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}
