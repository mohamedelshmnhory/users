import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/data/failures.dart';
import '../../../core/utils/nullable.dart';
import '../../authentication/register/data/model/user.dart';
import '../data/models/favourites_response_model.dart';
import '../data/models/favourites_request_params.dart';
import '../data/repo/favourites_repo.dart';

part 'favourites_state.dart';

@singleton
class FavouritesCubit extends Cubit<FavouritesState> {
  final FavouritesRepo favouritesRepo;
  FavouritesCubit(this.favouritesRepo) : super(FavouritesState());

  List<User> users = [];

  void getFavourites(FavouritesRequestParams? params) async {
    emit(state.requestLoading());

    params ??= FavouritesRequestParams();

    final result = await favouritesRepo.getFavourites(params);

    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        users = r.data ?? [];

        emit(state.requestSuccess());
      },
    );
  }

  void addFavourite(User model) async {
    emit(state.requestLoading());
    final result = await favouritesRepo.add(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        model.is_favourite = true;
        users.add(model);
        emit(state.addRequestSuccess());
      },
    );
  }

  void deleteFavourite(User model) async {
    emit(state.requestLoading());
    final result = await favouritesRepo.delete(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        model.is_favourite = false;
        users.remove(model);
        emit(state.addRequestSuccess());
      },
    );
  }
}
