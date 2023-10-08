import 'package:injectable/injectable.dart';
import 'package:users/core/dependencies/dependency_init.dart';
import '../../register/data/model/login_model.dart';
import '../data/repo/auth_repo.dart';

@Singleton()
class AuthHandler {
  AuthHandler(this._authRepository) {
    appStarted();
  }
  final AuthRepository _authRepository;

  LoginModel? loginModel;

  Future<bool> appStarted() async {
    loginModel = await _authRepository.getUser();
    if (loginModel != null) {
      await _authRepository.setToken(loginModel!.token!);
      return false;
    } else {
      return await _authRepository.isFirstTime();
    }
  }

  void firstOpen() async => await _authRepository.setFirstTime(false);

  Future<void> saveLogin(LoginModel model) async {
    loginModel = model;
    try {
      await _authRepository.setToken(model.token!);
      await _authRepository.setUser(model);
    } catch (e) {
      print(e);
    }
  }

  Future<void> logOut() async {
    loginModel = null;

    await _authRepository.deleteUser();
  }
}
