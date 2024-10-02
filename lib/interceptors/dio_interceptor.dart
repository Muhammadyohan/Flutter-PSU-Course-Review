import 'package:dio/dio.dart';
import 'package:flutter_psu_course_review/services/services.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await Store.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';
    options.baseUrl = 'http://10.0.2.2:8000';

    super.onRequest(options, handler);
  }
}
