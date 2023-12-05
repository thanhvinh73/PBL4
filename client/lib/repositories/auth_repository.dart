import 'package:client/models/credential/credential.dart';
import 'package:client/models/user/user.dart';
import 'package:client/services/api_response/api_response.dart';
import 'package:client/services/apis/api_client.dart';

class AuthRepository {
  APIClient apis;
  AuthRepository({required this.apis});

  Future<ApiResponse<Credential>> login(String username, String password) =>
      apis.login({"username": username, "password": password});

  Future logout() => apis.logout();

  Future<ApiResponse<User>> register(User user) {
    return apis.register(user.toJson()
      ..addAll({
        "password": user.password,
        "confirm_password": user.confirmPassword,
      }));
  }

  Future<ApiResponse<Credential>> refreshToken() => apis.refreshToken();
}
