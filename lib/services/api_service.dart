import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/interceptors/interceptors.dart';
import 'package:flutter_psu_course_review/services/services.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(path, queryParameters: queryParameters);
    return response;
  }

  Future<Response> post(
    String path, {
    Object? data,
    Options? options,
  }) async {
    final response = await _dio.post(path, data: data, options: options);
    return response;
  }

  Future<Response> put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    final response =
        await _dio.put(path, data: data, queryParameters: queryParameters);
    return response;
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.delete(path, queryParameters: queryParameters);
    return response;
  }

  Future<String> login(
      {required String username, required String password}) async {
    try {
      final response = await post(
        '/token',
        data: FormData.fromMap({'username': username, 'password': password}),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        await Store.setToken(token);
        return "Logged in successfully";
      } else if (response.statusCode == 401) {
        // detail: Incorrect username or password.
        return response.data['detail'];
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<void> logout() async {
    await Store.clearToken();
  }
}
