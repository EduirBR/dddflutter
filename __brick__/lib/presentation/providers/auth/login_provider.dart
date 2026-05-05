import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/infraestructure/models/response_model.dart';
import 'package:{{project_name}}/presentation/providers/auth/auth_provider.dart';
import 'package:{{project_name}}/presentation/providers/auth/auth_repository_provider.dart';
import 'package:{{project_name}}/presentation/services/notification_service.dart';
import 'package:{{project_name}}/utils/extra_tools.dart';

final loginProvider =
    NotifierProvider.autoDispose<LoginStateNotifier, LoginState>(
      LoginStateNotifier.new,
    );

class LoginStateNotifier extends Notifier<LoginState> {
  late final RequestFunction _loginRequest;
  late final AuthProviderNotifier _authNotifier;

  @override
  LoginState build() {
    _loginRequest = ref.read(authRepositoryProvider).login;
    _authNotifier = ref.read(authProvider.notifier);
    return LoginState();
  }

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    return isValidEmail(value) ? null : 'Invalid email';
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Future<bool> validateForm() async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      state = state.copyWith(
        email: emailController.text,
        password: passwordController.text,
      );
    }
    return isValidForm;
  }

  Future<Error?> login() async {
    final data = state.toJson();
    state = state.copyWith(isLoading: true);
    final response = await _loginRequest(data);
    if (response.error) {
      state = state.copyWith(isLoading: false, errorMessage: response.message);
      NotificationService.showSnackbarError(response.message);
      return Error();
    }
    await _authNotifier.setAuthenticated(
      response.data!['access'],
      response.data!['refresh'],
    );
    await _authNotifier.getUserData();
    return null;
  }
}

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
