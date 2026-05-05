import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name}}/domain/repositories/example_repository.dart';
import 'package:{{project_name}}/infraestructure/datasources/example_datasource_impl.dart';
import 'package:{{project_name}}/infraestructure/repositories/example_repository_impl.dart';

final exampleRepositoryProvider = Provider<ExampleRepository>((ref) {
  return ExampleRepositoryImpl(datasource: ExampleDatasourceImpl());
});
