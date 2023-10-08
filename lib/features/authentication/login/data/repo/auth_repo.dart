import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:users/core/services/cache_helper.dart';
import '../../../../../core/data/request/base_request.dart';
import '../../../../../core/services/app_local_storage.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../register/data/model/login_model.dart';

@injectable
class AuthRepository {
  final String _sharedPreferenceToken = "Token";
  final String _sharedPreferenceFirst = "First";
  final String _userKey = "User";

  final StorageService _storageService;

  AuthRepository( this._storageService);

  Future<String?> get accessToken async => await _getToken();

  Future setToken(String userToken) async {
    BaseRequestDefaults.instance.setToken(userToken);
    if (kIsWeb) return; //todo
    return await _storageService.saveString(_sharedPreferenceToken, userToken);
  }

  Future<String?> _getToken() async {
    return _storageService.getString(_sharedPreferenceToken);
  }

  Future<bool> isFirstTime() async {
    return await _storageService.getBool(_sharedPreferenceFirst) ?? true;
  }

  Future setFirstTime(bool isFirst) async {
    return await _storageService.saveBool(_sharedPreferenceFirst, isFirst);
  }

  Future setUser(LoginModel loginModel) async {
    if (kIsWeb) return; //todo
    return await _storageService.saveMap(_userKey, loginModel.toJson());
  }

  Future<LoginModel?> getUser() async {
    final loginModel = await _storageService.getMap(_userKey);
    if (loginModel == null) return null;
    return LoginModel.fromJson(loginModel);
  }

  Future deleteUser() async {
    return await _storageService.deleteMap(_userKey);
  }

  void refreshTheToken(Dio refreshTokenDio) {}
}
