import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/domain/repositories/example_repository.dart';
import 'package:{{project_name}}/infraestructure/datasources/example_datasource_impl.dart';
import 'package:{{project_name}}/infraestructure/repositories/example_repository_impl.dart';

/// Provider for the AuthRepository
/// This provider creates an instance of ExampleRepositoryImpl using ExampleDatasourceImpl
/// as the datasource.
final authRepositoryProvider = Provider<ExampleRepository>((ref) {
  return ExampleRepositoryImpl(datasource: ExampleDatasourceImpl());
});
