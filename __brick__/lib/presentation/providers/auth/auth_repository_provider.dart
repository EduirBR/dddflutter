import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/domain/repositories/auth_repository.dart';
import 'package:{{project_name}}/infraestructure/datasources/auth_datasource_impl.dart';
import 'package:{{project_name}}/infraestructure/repositories/auth_repository_impl.dart';

/// Provider for the AuthRepository
/// This provider creates an instance of AuthRepositoryImpl using AuthDatasourceImpl
/// as the datasource.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(datasource: AuthDatasourceImpl());
});
