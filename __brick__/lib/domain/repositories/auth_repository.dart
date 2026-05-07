import 'package:{{project_name}}/infraestructure/models/response_model.dart';

abstract class AuthRepository {
  Future<ResponseModel> login(Map<String, dynamic> data);
  Future<ResponseModel> logout();
  Future<ResponseModel> refreshToken(String refreshToken);
}
