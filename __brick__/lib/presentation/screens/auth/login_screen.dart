import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:{{project_name}}/presentation/providers/auth/login_provider.dart';
import 'package:{{project_name}}/presentation/widgets/panel_loading_indicator.dart';

class LoginScreen extends ConsumerWidget {
  static const name = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.watch(loginProvider.notifier);
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: loginNotifier.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '{{app_title}}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: loginNotifier.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: loginNotifier.validateEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: loginNotifier.passwordController,
                      obscureText: true,
                      validator: loginNotifier.validatePassword,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        final isValidForm = await loginNotifier.validateForm();
                        if (!isValidForm) return;
                        final err = await loginNotifier.login();
                        if (err != null) return;
                        if (context.mounted) context.go('/home');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (loginState.isLoading) const PanelLoadingIndicator(),
        ],
      ),
    );
  }
}
