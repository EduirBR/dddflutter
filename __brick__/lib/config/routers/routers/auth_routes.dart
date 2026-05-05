import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:{{project_name}}/config/routers/router_handler.dart';
import 'package:{{project_name}}/presentation/providers/auth/auth_provider.dart';
import 'package:{{project_name}}/presentation/screens/screens.dart';

/// Returns auth routes with authentication validation
/// These are PUBLIC routes - only accessible when NOT authenticated
List<RouteBase> getAuthRoutes(Ref ref) {
  bool isAuthenticated() {
    final authState = ref.read(authProvider);
    return authState.status == AuthStatus.authenticated;
  }

  return [
    addPublicRoute(
      path: '/login',
      name: LoginScreen.name,
      isAuthenticated: isAuthenticated,
      view: const LoginScreen(),
      redirectTo: '/home',
    ),
    // TODO: Add more public routes here
    // addPublicRoute(
    //   path: '/register',
    //   name: RegisterScreen.name,
    //   isAuthenticated: isAuthenticated,
    //   view: const RegisterScreen(),
    //   redirectTo: '/home',
    // ),
  ];
}

/// Legacy static routes (for backward compatibility)
/// DEPRECATED: Use getAuthRoutes(ref) instead
List<RouteBase> authRoutes = [];
