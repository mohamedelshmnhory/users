import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/data/failures.dart';
import '../../../core/dependencies/dependency_init.dart';
import '../../../core/profile_api.dart';
import '../../../core/utils/nullable.dart';
import '../../authentication/login/logic/auth_handler.dart';
import '../../authentication/register/data/model/user.dart';
import '../../users/logic/users_cubit.dart';
import '../data/models/profile_response_model.dart';
import '../data/repo/profile_repo.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileState());
  Future getProfile() async {
    if (getIt<AuthHandler>().loginModel != null) {
      final result = await profileRepo.getProfile(GENERIC());

      result.fold(
        (l) => emit(state.requestFailed(l)),
        (r) async {
          emit(state.requestLoading());
          final bloc = getIt<AuthHandler>();
          await bloc.saveLogin(bloc.loginModel!..user = r.data);
          emit(state.requestSuccess(profileResponseModel:r));
        },
      );
    }
  }

  Future updateProfile(User user) async {
    if (getIt<AuthHandler>().loginModel != null) {
      emit(state.requestLoading());
      final result = await profileRepo.updateProfile(user);

      result.fold(
        (l) => emit(state.requestFailed(l)),
        (r) async {
          final bloc = getIt<AuthHandler>();
          await bloc.saveLogin(bloc.loginModel!..user = r.data);
          final int index = getIt<UsersCubit>().users.indexWhere((element) => element.id == r.data.id);
          if (index != -1) {
            getIt<UsersCubit>().users[index] = r.data;
            getIt<UsersCubit>().emit(UsersState().addRequestSuccess());
          }
          emit(state.requestSuccess(profileResponseModel:r));
        },
      );
    }
  }

  // Future getSettings() async {
  //   emit(state.requestLoading());
  //   final result = await profileRepo.getSettings();
  //
  //   result.fold(
  //     (l) => emit(state.requestFailed(l)),
  //     (r) {
  //       emit(state.requestSuccess());
  //     },
  //   );
  // }
}
