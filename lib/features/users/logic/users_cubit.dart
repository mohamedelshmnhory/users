import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/data/failures.dart';
import '../../../core/utils/nullable.dart';
import '../../authentication/register/data/model/user.dart';
import '../data/models/users_response_model.dart';
import '../data/models/users_request_params.dart';
import '../data/repo/users_repo.dart';

part 'users_state.dart';

@singleton
class UsersCubit extends Cubit<UsersState> {
  final UsersRepo usersRepo;
  UsersCubit(this.usersRepo) : super(UsersState());

  List<User> users = [];
  bool reachMaX = true;
  int page = 1;

  void getUsers(UsersRequestParams? params) async {
    if (params?.more == true) {
      page++;
    } else {
      page = 1;
      emit(state.requestLoading());
    }
    params ??= UsersRequestParams();
    params.page = page;
    final result = await usersRepo.getUsers(params);

    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        if (params?.more == true) {
          users.addAll(r.results ?? []);
        } else {
          users = r.results ?? [];
        }
        reachMaX = r.next == null;
        emit(state.requestSuccess());
      },
    );
  }

  void getUser(User model) async {
    emit(state.requestLoading());
    final result = await usersRepo.getUser(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        emit(state.addRequestSuccess(user: r));
      },
    );
  }

  void addUser(User model) async {
    emit(state.requestLoading());
    final result = await usersRepo.addUser(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        users.add(r);
        emit(state.addRequestSuccess());
      },
    );
  }

  void updateUser(User model) async {
    emit(state.requestLoading());
    final result = await usersRepo.updateUser(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (newUser) {
        final int index = users.indexWhere((element) => element.id == model.id);
        if (index != -1) {
          users[index] = newUser;
        } else {
          // Handle the case when the user is not found in the list
        }
        emit(state.addRequestSuccess(user: newUser));
      },
    );
  }

  void deleteUser(User model) async {
    emit(state.requestLoading());
    final result = await usersRepo.deleteUser(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        users.remove(model);
        emit(state.addRequestSuccess());
      },
    );
  }
}
