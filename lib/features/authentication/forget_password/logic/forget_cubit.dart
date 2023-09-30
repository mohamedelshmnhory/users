import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/api_manager.dart';
import '../../../../core/utils/nullable.dart';
import '../../register/data/model/user.dart';
import '../data/model/forget_response_model.dart';
import '../data/repo/forget_repo.dart';

part 'forget_state.dart';

@injectable
class ForgetCubit extends Cubit<ForgetState> {
  final ForgetRepo _forgetRepo;

  ForgetCubit(this._forgetRepo) : super(const ForgetState());

  Future<void> forgetRequest({required User user}) async {
    emit(state.requestLoading());
    final result = await _forgetRepo.forgetRequest(user: user);

    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) => emit(state.requestSuccess(r)),
    );
  }

  Future<void> forgetUpdate({required User user}) async {
    emit(state.requestLoading());
    final result = await _forgetRepo.forgetUpdate(user: user);

    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) => emit(state.requestSuccess(r)),
    );
  }
}
