import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:users/core/profile_api.dart';

import '../../../../core/data/api_manager.dart';
import '../../../authentication/register/data/model/user.dart';
import '../models/profile_response_model.dart';
import '../request/profile_request.dart';
import 'package:http_parser/http_parser.dart';

@injectable
class ProfileRepo {
  final APIsManager _apIsManager;

  ProfileRepo(this._apIsManager);

  Future<Either<Failure, ProfileResponseModel>> getProfile(GENERIC profile) async {
    // return Future.delayed(const Duration(milliseconds: 500)).then(
    //   (value) => Right(ProfileResponseModel.fromMap(moocUserProfile())),
    // );
    return await _apIsManager.send(
      request: ProfileRequest(profileApi: profile),
      responseFromMap: (map) => ProfileResponseModel.fromJson(map),
    );
  }

  Future<Either<Failure, ProfileResponseModel>> updateProfile(User user) async {
    if (user.avatar is XFile) {
      List<int> data = await (user.avatar as XFile).readAsBytes();
      user.avatar = MultipartFile.fromBytes(
        data,
        filename: user.avatar!.path.split('/').last + '.jpeg',
        contentType: MediaType('image', 'jpeg'),
      );
    } else if (user.avatar is File) {
      user.avatar = await MultipartFile.fromFile(user.avatar.path, filename: user.avatar!.path.split('/').last);
    }
    return await _apIsManager.send(
      request: ProfileUpdateRequest(GENERIC(), user, isFile: user.avatar is MultipartFile),
      responseFromMap: (map) => ProfileResponseModel.fromJson(map),
    );
  }
}
