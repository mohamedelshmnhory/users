
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/api_manager.dart';
import '../../../../core/dependencies/dependency_init.dart';
import '../../login/data/model/login_response_model.dart';
import '../../login/logic/auth_handler.dart';
import '../data/model/user.dart';
import '../data/repo/register_repo.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _repository;

  RegisterCubit(this._repository) : super(const RegisterState());

  void register({required User user}) async {
    emit(state.requestLoading());
    var result = await _repository.register(user: user);

    result.fold(
      (l) => emit(state.requestFailure(l)),
      (r) {
        getIt<AuthHandler>().saveLogin(r.data);
        emit(state.registerSuccess(r));
      },
    );
  }


}


