import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/domain/entities/example_model.dart';
import 'package:{{project_name}}/domain/repositories/auth_repository.dart';
import 'package:{{project_name}}/presentation/providers/auth/auth_repository_provider.dart';
import 'package:{{project_name}}/presentation/providers/general/secure_storage_provider.dart';
import 'package:{{project_name}}/presentation/services/notification_service.dart';

final authProvider = NotifierProvider<AuthProviderNotifier, AuthState>(
  AuthProviderNotifier.new,
);

class AuthProviderNotifier extends Notifier<AuthState> {
  late final SecureStorageService _secureStorageService;
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _secureStorageService = ref.read(secureStorageProvider);
    _authRepository = ref.read(authRepositoryProvider);
    return AuthState();
  }

  Future<void> setAuthenticated(String accessToken, String refreshToken) async {
    await _secureStorageService.setValue('access_token', accessToken);
    await _secureStorageService.setValue('refresh_token', refreshToken);
    state = state.copyWith(
      status: AuthStatus.authenticated,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> getUserData() async {
    try {
      // TODO: implement get user data from API
      // You should create a separate UserRepository for this
      await Future.delayed(const Duration(milliseconds: 500));
      final user = ExampleModel(name: 'User');
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  /// Check authentication status on app startup
  Future<void> checkAuthStatus() async {
    try {
      final accessToken = await _secureStorageService.getValue('access_token');

      if (accessToken != null && accessToken.isNotEmpty) {
        await getUserData();
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Failed to check authentication status',
      );
    }
  }

  /// Logout the user
  Future<void> logout() async {
    try {
      await _secureStorageService.deleteValue('access_token');
      await _secureStorageService.deleteValue('refresh_token');

      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
        errorMessage: 'Logout completed with errors',
      );
    }
  }

  /// Clear any error messages
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

enum AuthStatus { undefined, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final ExampleModel? user;
  final String? accessToken;
  final String? refreshToken;

  AuthState({
    this.status = AuthStatus.undefined,
    this.errorMessage,
    this.user,
    this.accessToken,
    this.refreshToken,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    ExampleModel? user,
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
