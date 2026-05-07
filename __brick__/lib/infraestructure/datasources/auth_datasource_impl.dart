import 'package:{{project_name}}/domain/datasources/auth_datasource.dart';
import 'package:{{project_name}}/infraestructure/models/response_model.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<ResponseModel> login(Map<String, dynamic> data) async {
    // TODO: implement login API call
    await Future.delayed(const Duration(seconds: 1));
    return ResponseModel(
      error: false,
      message: 'Login successful',
      data: {'access': 'access_token', 'refresh': 'refresh_token'},
    );
  }

  @override
  Future<ResponseModel> logout() async {
    // TODO: implement logout API call
    await Future.delayed(const Duration(milliseconds: 500));
    return ResponseModel(error: false, message: 'Logout successful');
  }

  @override
  Future<ResponseModel> refreshToken(String refreshToken) async {
    // TODO: implement refresh token API call
    await Future.delayed(const Duration(milliseconds: 500));
    return ResponseModel(
      error: false,
      message: 'Token refreshed',
      data: {'access': 'new_access_token'},
    );
  }
}
