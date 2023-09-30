// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritesRequestParams _$FavouritesRequestParamsFromJson(
        Map<String, dynamic> json) =>
    FavouritesRequestParams(
      perPage: json['perPage'] as num?,
      page: json['page'] as num?,
      username: json['username'] as String?,
      more: json['more'] as bool?,
    );

Map<String, dynamic> _$FavouritesRequestParamsToJson(
    FavouritesRequestParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('perPage', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('username', instance.username);
  writeNotNull('more', instance.more);
  return val;
}
