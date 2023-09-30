import 'package:json_annotation/json_annotation.dart';

import '../../../../core/data/models/request_model.dart';

part 'job.g.dart';

@JsonSerializable(includeIfNull: false)
//ignore: must_be_immutable
class Job extends RequestModel {
  final num? id;
  String? name;
  String? description;

  Job({this.id, this.name, this.description}) : super(null);

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JobToJson(this);

  @override
  List<Object?> get props => [id, name];
}
