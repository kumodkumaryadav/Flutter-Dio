import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_best_practise/const/api_const.dart';
import 'package:get/get.dart';

import '../storage/auth_service.dart';

class AuthInterceptor extends Interceptor {
   final AuthService authService = Get.put(AuthService());

  late final Dio _dio;
  late final Dio _tokenDio; // Dio instance for token requests

  // Base URL for token endpoints

  // Your token endpoints

  // Your token storage mechanism (e.g., Shared Preferences)
  // Example:
  // final _tokenStorage = SharedPreferences.getInstance();

  AuthInterceptor(Dio dio) {
    _dio = dio;
    _tokenDio = Dio();
    _tokenDio.options.baseUrl = ApiConst.baseUrl;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Retrieve access token from storage
     final String? accessToken = authService.accessToken;


    if (accessToken != null) {
      // Add access token to request headers
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Proceed with the request
    handler.next(options);
  }

 

  Future<void> _refreshToken() async {
    // Retrieve refresh token from storage
    // Example:
    // final String? refreshToken = _tokenStorage.getString('refreshToken');

    // For demonstration purposes, a hardcoded refresh token is used
    final String? refreshToken = authService.refreshToken;

    if (refreshToken != null) {
      try {
        // Make a request to refresh token endpoint
        final response = await _tokenDio.post(ApiConst.refreshTokenEndpoint, data: {
          'refresh_token': refreshToken,
        });

        // Extract and save new access token
        final newAccessToken = response.data['access_token'];
        // Example:
        // _tokenStorage.setString('accessToken', newAccessToken);

        // Update authorization header in Dio instance
        _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
      } catch (error) {
        // Handle token refresh error
        print('Failed to refresh token: $error');
        throw Exception('Failed to refresh token');
      }
    }
  }
}
