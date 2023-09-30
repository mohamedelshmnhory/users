import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/data/request/base_request.dart';
import '../../../../../core/services/app_local_storage.dart';
import '../../../register/data/model/login_model.dart';

@injectable
class AuthRepository {
  final String _sharedPreferenceToken = "Token";
  final String _sharedPreferenceFirst = "First";
  final String _userKey = "User";

  Future<String?> get accessToken async => await _getToken();

  Future setToken(String userToken) async {
    BaseRequestDefaults.instance.setToken(userToken);
    return await AppLocalStorage.saveString(_sharedPreferenceToken, userToken);
  }

  Future<String?> _getToken() async {
    return AppLocalStorage.getString(_sharedPreferenceToken);
  }

  Future<bool> isFirstTime() async {
    return await AppLocalStorage.getBool(_sharedPreferenceFirst) ?? true;
  }

  Future setFirstTime(bool isFirst) async {
    return await AppLocalStorage.saveBool(_sharedPreferenceFirst, isFirst);
  }

  Future setUser(LoginModel loginModel) async {
    loginModel.user?.data = null;
    return await AppLocalStorage.saveMap(_userKey, loginModel.toJson());
  }

  Future<LoginModel?> getUser() async {
    final loginModel = await AppLocalStorage.getMap(_userKey);
    if (loginModel == null) return null;
    return LoginModel.fromJson(loginModel);
  }

  Future deleteUser() async {
    return await AppLocalStorage.deleteMap(_userKey);
  }

  refreshTheToken(Dio refreshTokenDio) {}
}
