// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritesResponseModel _$FavouritesResponseModelFromJson(
        Map<String, dynamic> json) =>
    FavouritesResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavouritesResponseModelToJson(
        FavouritesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
