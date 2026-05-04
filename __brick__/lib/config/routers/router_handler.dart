import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Add a route (no authentication check)
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

/// Custom transition for routes
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
      if (isAuthenticated()) return redirectTo;
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
      if (!isAuthenticated()) return redirectTo;
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
