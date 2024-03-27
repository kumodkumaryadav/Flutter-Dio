import 'package:dio/dio.dart';
import 'package:dio_best_practise/services/dio%20services/dio_interceptor.dart';

import '../../const/api_const.dart';

class ApiService {
  Dio _dio = Dio(BaseOptions(baseUrl: ApiConst.baseUrl));

  ApiService() {
    _dio.interceptors.add(AuthInterceptor(_dio));
    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
  }

  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return _callApi<T>('GET', endpoint,
        queryParameters: queryParameters, headers: headers);
  }

  Future<T> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, String>? queryParameters,
  }) async {
    print("data..........$data");
    return _callApi<T>('POST', endpoint, data: data, headers: headers);
  }

  Future<T> _callApi<T>(
    String method,
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    late Response response;

    try {
      switch (method) {
        case 'GET':
          response = await _dio.get(
            endpoint,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case 'POST':
          response = await _dio.post(
            endpoint,
            data: data,
            options: Options(headers: headers),
          );
          break;
        // Add cases for other HTTP methods like PUT, DELETE if needed
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return response.data as T;
    } on DioError catch (e) {
      if (e.response != null) {
        final int? statusCode = e.response!.statusCode;
        if (statusCode == 401) {
          // Handle unauthorized error (e.g., log out user)
          // For example: AuthService.logout();
        } else if (statusCode == 403) {
          // Handle forbidden error (e.g., re-login user)
          // For example: AuthService.relogin();
        }
      }
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception('Failed to perform API call: $e');
    }
  }
}

class DioExceptions implements Exception {
  final int? statusCode;
  final String? message;

  DioExceptions({this.statusCode, this.message});

  factory DioExceptions.fromDioError(DioError dioError) {
    String message = "Unexpected error occurred";
    int? statusCode;

    if (dioError.response != null) {
      statusCode = dioError.response!.statusCode;
      message = dioError.response!.statusMessage ?? "Unexpected error occurred";
    } else {
      message = dioError.message!;
    }

    return DioExceptions(statusCode: statusCode, message: message);
  }

  @override
  String toString() {
    return 'DioExceptions{statusCode: $statusCode, message: $message}';
  }
}
