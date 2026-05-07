import 'package:{{project_name}}/domain/datasources/auth_datasource.dart';
import 'package:{{project_name}}/domain/repositories/auth_repository.dart';
import 'package:{{project_name}}/infraestructure/models/response_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<ResponseModel> login(Map<String, dynamic> data) {
    return datasource.login(data);
  }

  @override
  Future<ResponseModel> logout() {
    return datasource.logout();
  }

  @override
  Future<ResponseModel> refreshToken(String refreshToken) {
    return datasource.refreshToken(refreshToken);
  }
}
