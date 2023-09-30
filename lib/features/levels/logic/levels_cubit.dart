import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/data/failures.dart';
import '../../../core/utils/nullable.dart';
import '../data/models/level.dart';
import '../data/models/level_response_model.dart';
import '../data/models/levels_request_params.dart';
import '../data/repo/levels_repo.dart';

part 'levels_state.dart';

@singleton
class LevelsCubit extends Cubit<LevelsState> {
  final LevelsRepo levelsRepo;
  LevelsCubit(this.levelsRepo) : super(LevelsState());

  List<Level> levels = [];
  bool reachMaX = true;
  int page = 1;

  void getLevels({bool more = false, LevelsRequestParams? params}) async {
    //No need to repeat the request every time the user enters the screen.
    if (levels.isNotEmpty) return;

    if (more) {
      page++;
    } else {
      page = 1;
      emit(state.requestLoading());
    }
    params ??= LevelsRequestParams();
    params.page = page;
    final result = await levelsRepo.getLevels(params);

    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        if (more) {
          levels.addAll(r.results ?? []);
        } else {
          levels = r.results ?? [];
        }
        reachMaX = r.next == null;
        emit(state.requestSuccess());
      },
    );
  }

  void getLevel(Level model) async {
    emit(state.requestLoading());
    final result = await levelsRepo.getLevel(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        emit(state.addRequestSuccess(model: r));
      },
    );
  }

  void addLevel(Level model) async {
    emit(state.requestLoading());
    final result = await levelsRepo.addLevel(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        levels.add(r);
        emit(state.addRequestSuccess());
      },
    );
  }

  void updateLevel(Level model) async {
    emit(state.requestLoading());
    final result = await levelsRepo.updateLevel(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        final int index = levels.indexOf(model);
        levels[index] = r;
        emit(state.addRequestSuccess());
      },
    );
  }

  void deleteLevel(Level model) async {
    emit(state.requestLoading());
    final result = await levelsRepo.deleteLevel(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        levels.remove(model);
        emit(state.addRequestSuccess());
      },
    );
  }
}
