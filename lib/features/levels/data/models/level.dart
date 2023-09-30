import 'package:json_annotation/json_annotation.dart';

import '../../../../core/data/models/request_model.dart';

part 'level.g.dart';

@JsonSerializable(includeIfNull: false)
//ignore: must_be_immutable
class Level extends RequestModel {
  final num? id;
  String? name;
  String? description;

  Level({this.id, this.name, this.description}) : super(null);

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LevelToJson(this);

  @override
  List<Object?> get props => [id, name];
}
