import 'package:flutter_batch_9_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_batch_9_project/models/auth_response_model.dart';
import 'package:flutter_batch_9_project/models/user_model.dart';

abstract class AuthRemoteData {
  Future<AuthResponseModel> postLogin(String email, String password);
  Future<User> getProfile();
}

class AuthRemoteDataImpl implements AuthRemoteData {

  final NetworkService _networkService;

  AuthRemoteDataImpl(this._networkService);

  @override
  Future<AuthResponseModel> postLogin(String email, String password) async {
    try {
      final response = await _networkService.post(
        url: '/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthResponseModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      final response = await _networkService.get(url: '/api/profile/me');
      return User.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }
}