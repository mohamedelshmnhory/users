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

import '../../features/authentication/firebase/data/repo/firebase_repo.dart'
    as _i7;
import '../../features/authentication/firebase/logic/firebase_cubit.dart'
    as _i16;
import '../../features/authentication/forget_password/data/repo/forget_repo.dart'
    as _i8;
import '../../features/authentication/forget_password/logic/forget_cubit.dart'
    as _i17;
import '../../features/authentication/login/data/repo/auth_repo.dart' as _i5;
import '../../features/authentication/login/data/repo/login_repo.dart' as _i11;
import '../../features/authentication/login/logic/auth_handler.dart' as _i4;
import '../../features/authentication/login/logic/login_cubit.dart' as _i20;
import '../../features/authentication/register/data/repo/register_repo.dart'
    as _i13;
import '../../features/authentication/register/logic/register_cubit.dart'
    as _i22;
import '../../features/favourites/data/repo/favourites_repo.dart' as _i6;
import '../../features/favourites/logic/favourites_cubit.dart' as _i15;
import '../../features/home/data/repo/jobs_repo.dart' as _i9;
import '../../features/home/logic/jobs_cubit.dart' as _i18;
import '../../features/levels/data/repo/levels_repo.dart' as _i10;
import '../../features/levels/logic/levels_cubit.dart' as _i19;
import '../../features/profile/data/repo/profile_repo.dart' as _i12;
import '../../features/profile/logic/profile_cubit.dart' as _i21;
import '../../features/users/data/repo/users_repo.dart' as _i14;
import '../../features/users/logic/users_cubit.dart' as _i23;
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
  gh.singleton<_i4.AuthHandler>(_i4.AuthHandler());
  gh.factory<_i5.AuthRepository>(() => _i5.AuthRepository());
  gh.factory<_i6.FavouritesRepo>(
      () => _i6.FavouritesRepo(gh<_i3.APIsManager>()));
  gh.factory<_i7.FirebaseRepo>(() => _i7.FirebaseRepo());
  gh.factory<_i8.ForgetRepo>(() => _i8.ForgetRepo(gh<_i3.APIsManager>()));
  gh.factory<_i9.JobsRepo>(() => _i9.JobsRepo(gh<_i3.APIsManager>()));
  gh.factory<_i10.LevelsRepo>(() => _i10.LevelsRepo(gh<_i3.APIsManager>()));
  gh.factory<_i11.LoginRepo>(() => _i11.LoginRepo(gh<_i3.APIsManager>()));
  gh.factory<_i12.ProfileRepo>(() => _i12.ProfileRepo(gh<_i3.APIsManager>()));
  gh.factory<_i13.RegisterRepository>(
      () => _i13.RegisterRepository(gh<_i3.APIsManager>()));
  gh.factory<_i14.UsersRepo>(() => _i14.UsersRepo(gh<_i3.APIsManager>()));
  gh.singleton<_i15.FavouritesCubit>(
      _i15.FavouritesCubit(gh<_i6.FavouritesRepo>()));
  gh.factory<_i16.FirebaseCubit>(
      () => _i16.FirebaseCubit(gh<_i7.FirebaseRepo>()));
  gh.factory<_i17.ForgetCubit>(() => _i17.ForgetCubit(gh<_i8.ForgetRepo>()));
  gh.factory<_i18.JobsCubit>(() => _i18.JobsCubit(gh<_i9.JobsRepo>()));
  gh.singleton<_i19.LevelsCubit>(_i19.LevelsCubit(gh<_i10.LevelsRepo>()));
  gh.factory<_i20.LoginCubit>(() => _i20.LoginCubit(gh<_i11.LoginRepo>()));
  gh.factory<_i21.ProfileCubit>(
      () => _i21.ProfileCubit(gh<_i12.ProfileRepo>()));
  gh.factory<_i22.RegisterCubit>(
      () => _i22.RegisterCubit(gh<_i13.RegisterRepository>()));
  gh.singleton<_i23.UsersCubit>(_i23.UsersCubit(gh<_i14.UsersRepo>()));
  return getIt;
}
