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
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> post(String path, {Object? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.put(path, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> login(
      {required String username, required String password}) async {
    try {
      final response = await post(
        '/token',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode != 200) {
        return false;
      }

      final token = response.data['access_token'];
      await Store.setToken(token);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
