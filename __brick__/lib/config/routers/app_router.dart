import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:{{project_name}}/presentation/providers/auth/auth_provider.dart';
import 'routers/routes.dart';

/// Provider for GoRouter with authentication support
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.read(authProvider);

  final refreshNotifier = ValueNotifier<int>(0);
  ref.listen<AuthState>(authProvider, (previous, next) {
    refreshNotifier.value++;
  });

  return GoRouter(
    refreshListenable: refreshNotifier,
    initialLocation: _getInitialLocation(authState),
    routes: [
      ...getAuthRoutes(ref),
      ...getPrivateRoutes(ref),
    ],
    redirect: (context, state) {
      final currentAuth = ref.read(authProvider);
      final isAuthenticating = currentAuth.status == AuthStatus.undefined;

      if (isAuthenticating) {
        return null;
      }

      return null;
    },
  );
});

/// Determines the initial route based on authentication status
String _getInitialLocation(AuthState authState) {
  switch (authState.status) {
    case AuthStatus.authenticated:
      return '/home';
    case AuthStatus.unauthenticated:
      return '/login';
    case AuthStatus.undefined:
      return '/login';
  }
}
