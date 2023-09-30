import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/data/general_response.dart';
import '../../../authentication/register/data/model/user.dart';

part 'favourites_response_model.g.dart';

@JsonSerializable()
class FavouritesResponseModel extends GeneralResponse {
  final List<User>? data;

  const FavouritesResponseModel({required super.status, super.message, this.data});

  factory FavouritesResponseModel.fromJson(Map<String, dynamic> json) => _$FavouritesResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FavouritesResponseModelToJson(this);

  @override
  List<Object?> get props => [];
}
