import 'package:{{project_name}}/domain/datasources/example_datasource.dart';
import 'package:{{project_name}}/infraestructure/models/response_model.dart';

class ExampleDatasourceImpl extends ExampleDatasource {
  @override
  Future<ResponseModel> create(Map<String, dynamic> data) async {
    // TODO: Implement API call
    return ResponseModel(
      error: true,
      message: 'Create is currently unavailable',
      data: null,
    );
  }

  @override
  Future<ResponseModel> delete(String id) async {
    // TODO: Implement API call
    return ResponseModel(
      error: true,
      message: 'Delete is currently unavailable',
      data: null,
    );
  }

  @override
  Future<ResponseModel> getAll() async {
    // TODO: Implement API call
    return ResponseModel(
      error: true,
      message: 'GetAll is currently unavailable',
      data: null,
    );
  }

  @override
  Future<ResponseModel> getById(String id) async {
    // TODO: Implement API call
    return ResponseModel(
      error: true,
      message: 'GetById is currently unavailable',
      data: null,
    );
  }

  @override
  Future<ResponseModel> update(Map<String, dynamic> data) async {
    // TODO: Implement API call
    return ResponseModel(
      error: true,
      message: 'Update is currently unavailable',
      data: null,
    );
  }
}
