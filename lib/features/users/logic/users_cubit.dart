import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/data/failures.dart';
import '../../../core/utils/nullable.dart';
import '../data/models/user_response_model.dart';
import '../data/models/users_request_params.dart';
import '../data/repo/users_repo.dart';

part 'users_state.dart';

@injectable
class UsersCubit extends Cubit<UsersState> {
  final UsersRepo usersRepo;
  UsersCubit(this.usersRepo) : super(UsersState());

  List<UserModel> users = [];
  bool reachMaX = true;
  int page = 1;

  void getUsers({bool more = false, UsersRequestParams? params}) async {
    if (more) {
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
        if (more) {
          users.addAll(r.data ?? []);
        } else {
          users = r.data ?? [];
        }
        reachMaX = r.page == r.total_pages;
        emit(state.requestSuccess(model: r));
      },
    );
  }

  void getUser(UserModel model) async {
    emit(state.requestLoading());
    final result = await usersRepo.getUser(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        emit(state.addRequestSuccess(model: r));
      },
    );
  }
}
