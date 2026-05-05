import 'package:{{project_name}}/domain/datasources/example_datasource.dart';
import 'package:{{project_name}}/domain/repositories/example_repository.dart';
import 'package:{{project_name}}/infraestructure/models/response_model.dart';

class ExampleRepositoryImpl extends ExampleRepository {
  final ExampleDatasource datasource;

  ExampleRepositoryImpl({required this.datasource});

  @override
  Future<ResponseModel> create(Map<String, dynamic> data) {
    return datasource.create(data);
  }

  @override
  Future<ResponseModel> delete(String id) {
    return datasource.delete(id);
  }

  @override
  Future<ResponseModel> getAll() {
    return datasource.getAll();
  }

  @override
  Future<ResponseModel> getById(String id) {
    return datasource.getById(id);
  }

  @override
  Future<ResponseModel> update(Map<String, dynamic> data) {
    return datasource.update(data);
  }
}
