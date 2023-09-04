// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/users/data/repo/users_repo.dart' as _i4;
import '../../features/users/logic/users_cubit.dart' as _i5;
import '../data/api_manager.dart' as _i3;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.APIsManager>(() => _i3.APIsManager());
  gh.factory<_i4.UsersRepo>(() => _i4.UsersRepo(gh<_i3.APIsManager>()));
  gh.factory<_i5.UsersCubit>(
      () => _i5.UsersCubit(gh<_i4.UsersRepo>()));
  return getIt;
}
