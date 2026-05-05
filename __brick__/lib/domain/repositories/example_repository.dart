import 'package:{{project_name}}/infraestructure/models/response_model.dart';

abstract class ExampleRepository {
  Future<ResponseModel> getAll();
  Future<ResponseModel> getById(String id);
  Future<ResponseModel> create(Map<String, dynamic> data);
  Future<ResponseModel> update(Map<String, dynamic> data);
  Future<ResponseModel> delete(String id);
}
