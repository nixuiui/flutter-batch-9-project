import 'package:dio/dio.dart';
import 'package:flutter_batch_9_project/data/remote_data/auth_remote_data.dart';
import 'package:flutter_batch_9_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {
  late AuthRemoteData authRemoteData;
  late MockNetworkService mockNetworkService;

  setUp(() {
    mockNetworkService = MockNetworkService();
    authRemoteData = AuthRemoteDataImpl(mockNetworkService);
  });

  group("AuthRemoteData", () {
    test("Login username & password success", () async {
      final email = "admin@gmail.com";
      final password = "admin123";
      final path = "/api/auth/login";

      final Map<String, dynamic> mockResponseData = {
        "data": {
          "user": {
            "id": 1,
            "name": "Admin",
            "email": "admin@gmail.com",
          },
          "access_token": "randomAccessToken",
        }
      };

      final mockResponse = Response(
          requestOptions: RequestOptions(path: path),
          statusCode: 200,
          data: mockResponseData);

      when(mockNetworkService.post(
        url: path,
        data: anyNamed('data'),
      )).thenAnswer((_) async => mockResponse);

      final result = await authRemoteData.postLogin(email, password);

      verify(mockNetworkService.post(
        url: path,
        data: {
          "email": email,
          "password": password,
        },
      )).called(1);

      expect(result.accessToken, mockResponseData['data']['access_token']);
      expect(result.user?.id, mockResponseData['data']?['user']?['id']);
      expect(result.user?.name, mockResponseData['data']?['user']?['name']);
      expect(result.user?.email, mockResponseData['data']?['user']?['email']);
    });

    test("Throw error when login failed", () async {
      const email = "admin@gmail.com";
      const password = "123456";
      const path = "/api/auth/login";

      when(mockNetworkService.post(
        url: path,
        data: anyNamed('data'),
      )).thenThrow(Exception("Login Failed"));

      expect(() => authRemoteData.postLogin(email, password), throwsException);

      verify(mockNetworkService.post(
        url: path,
        data: {
          "email": email,
          "password": password,
        },
      )).called(1);
    });
  });
}
