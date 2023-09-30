import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:users/core/view/widgets/should_login.dart';
import 'package:users/features/favourites/view/screens/favourites_screen.dart';
import 'package:users/features/home/view/screens/home_screen.dart';
import 'package:users/features/levels/view/screens/levels_screen.dart';
import 'package:users/features/profile/view/edit_profile_screen.dart';
import 'package:users/features/profile/view/profile_screen.dart';
import '../core/dependencies/dependency_init.dart';
import '../features/authentication/forget_password/code_password_screen.dart';
import '../features/authentication/forget_password/enter_email_screen.dart';
import '../features/authentication/login/logic/auth_handler.dart';
import '../features/authentication/login/view/screen/login_screen.dart';
import '../features/authentication/register/data/model/user.dart';
import '../features/authentication/register/view/screens/register_screen.dart';
import '../features/home/data/models/job.dart';
import '../features/home/logic/jobs_cubit.dart';
import '../features/home/view/screens/add_edit_job.dart';
import '../features/layout/layout.dart';
import '../features/levels/data/models/level.dart';
import '../features/levels/data/models/levels_request_params.dart';
import '../features/levels/logic/levels_cubit.dart';
import '../features/levels/view/screens/add_edit_level.dart';
import '../features/users/view/screens/users_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final goRouter = GoRouter(
  initialLocation: HomeScreen.id,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: HomeScreen.id,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
              routes: [
                GoRoute(
                  path: LevelsScreen.id,
                  builder: (context, state) => LevelsScreen(job: state.extra as Job),
                  routes: [
                    GoRoute(
                      path: UsersScreen.id,
                      builder: (context, state) => UsersScreen(params: state.extra as LevelsRequestParams),
                      routes: [
                        GoRoute(
                          path: ProfileScreen.id,
                          pageBuilder: (context, state) {
                            return NoTransitionPage(
                              child: ProfileScreen(user: state.extra as User),
                            );
                          },
                        ),
                      ],
                    ),
                    GoRoute(
                      path: AddEditLevelScreen.id,
                      builder: (BuildContext context, GoRouterState state) {
                        final extras = state.extra as Map<String, dynamic>;
                        final level = extras['level'] as Level?;
                        final levelsCubit = extras['levelsCubit'] as LevelsCubit;
                        return AddEditLevelScreen(level: level, levelsCubit: levelsCubit);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: AddEditJobScreen.id,
                  builder: (BuildContext context, GoRouterState state) {
                    final extras = state.extra as Map<String, dynamic>;
                    final job = extras['job'] as Job?;
                    final jobsCubit = extras['jobsCubit'] as JobsCubit;
                    return AddEditJobScreen(job: job, jobsCubit: jobsCubit);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: FavouritesScreen.id,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ShouldLogin(child: FavouritesScreen()),
              ),
              routes: [
                GoRoute(
                  path: ProfileScreen.id,
                  builder: (context, state) => ProfileScreen(user: state.extra as User),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
              path: '/${ProfileScreen.id}',
              pageBuilder: (context, state) => NoTransitionPage(
                child: ShouldLogin(child: ProfileScreen(user: getIt<AuthHandler>().loginModel?.user ?? User())),
              ),
              routes: [
                GoRoute(
                  path: EditProfileScreen.id,
                  builder: (context, state) => EditProfileScreen(user: state.extra as User),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: LoginScreen.id,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: RegisterScreen.id,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      path: EnterEmailScreen.id,
      builder: (BuildContext context, GoRouterState state) {
        return const EnterEmailScreen();
      },
    ),
    GoRoute(
      path: CodePasswordScreen.id,
      builder: (BuildContext context, GoRouterState state) {
        return CodePasswordScreen(email: state.extra as String);
      },
    ),
  ],
);
