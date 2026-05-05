import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: Import your auth provider here
// import 'package:{{project_name}}/presentation/providers/auth/auth_provider.dart';

/// Add a view for any user (no authentication check)
RouteBase addRoute({
  required String path,
  required String name,
  Widget? view,
  GoRouterPageBuilder? builder,
  List<RouteBase> childRoutes = const <RouteBase>[],
}) {
  return GoRoute(
    name: name,
    path: path,
    routes: childRoutes,
    pageBuilder:
        builder ??
        (context, state) {
          if (view == null) {
            throw Exception('view must be defined if builder is not provided');
          }
          return customTransitionBuild(view);
        },
  );
}

/// Transition build if needed
CustomTransitionPage<dynamic> customTransitionBuild(Widget view) {
  return CustomTransitionPage(
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
    child: view,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

/// Add a public route (only accessible when NOT authenticated)
/// If user is authenticated, redirects to home
RouteBase addPublicRoute({
  required String path,
  required String name,
  required bool Function() isAuthenticated,
  Widget? view,
  GoRouterPageBuilder? builder,
  List<RouteBase> childRoutes = const <RouteBase>[],
  String redirectTo = '/home',
}) {
  return GoRoute(
    name: name,
    path: path,
    routes: childRoutes,
    redirect: (context, state) {
      if (isAuthenticated()) {
        return redirectTo;
      }
      return null;
    },
    pageBuilder:
        builder ??
        (context, state) {
          if (view == null) {
            throw Exception('view must be defined if builder is not provided');
          }
          return customTransitionBuild(view);
        },
  );
}

/// Add a private route (only accessible when authenticated)
/// If user is NOT authenticated, redirects to login
RouteBase addPrivateRoute({
  required String path,
  required String name,
  required bool Function() isAuthenticated,
  Widget? view,
  GoRouterPageBuilder? builder,
  List<RouteBase> childRoutes = const <RouteBase>[],
  String redirectTo = '/login',
}) {
  return GoRoute(
    name: name,
    path: path,
    routes: childRoutes,
    redirect: (context, state) {
      if (!isAuthenticated()) {
        return redirectTo;
      }
      return null;
    },
    pageBuilder:
        builder ??
        (context, state) {
          if (view == null) {
            throw Exception('view must be defined if builder is not provided');
          }
          return customTransitionBuild(view);
        },
  );
}
