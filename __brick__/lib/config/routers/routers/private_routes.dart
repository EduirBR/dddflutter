import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:{{project_name}}/config/routers/router_handler.dart';
import 'package:{{project_name}}/presentation/providers/auth/auth_provider.dart';
import 'package:{{project_name}}/presentation/screens/screens.dart';

/// Returns private routes with authentication validation
/// These are PRIVATE routes - only accessible when authenticated
List<RouteBase> getPrivateRoutes(Ref ref) {
  bool isAuthenticated() {
    final authState = ref.read(authProvider);
    return authState.status == AuthStatus.authenticated;
  }

  return [
    addPrivateRoute(
      path: '/home',
      name: HomeScreen.name,
      isAuthenticated: isAuthenticated,
      view: const HomeScreen(),
      redirectTo: '/login',
    ),
    // TODO: Add more private routes here
    // addPrivateRoute(
    //   path: '/profile',
    //   name: ProfileScreen.name,
    //   isAuthenticated: isAuthenticated,
    //   view: const ProfileScreen(),
    //   redirectTo: '/login',
    // ),
  ];
}
