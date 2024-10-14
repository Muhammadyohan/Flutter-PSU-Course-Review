import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/models/models.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';
import 'package:flutter_psu_course_review/services/api_service.dart';

class UserRepoFromDb extends UserRepository {
  late UserModel user;

  final ApiService apiService = ApiService();
  final String baseUri = '/users';

  @override
  Future<String> createUser(
      {required String email,
      required String username,
      required String firstName,
      required String lastName,
      required String password}) async {
    final Map<String, dynamic> userData = {
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.post('$baseUri/create', data: userData);
    if (response.statusCode == 200) {
      return "User created successfully";
    } else if (response.statusCode == 409) {
      // detail: This username is exists.
      return response.data['detail'];
    } else {
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<String> loginUser({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 0));
    final responseText =
        await apiService.login(username: username, password: password);
    return responseText;
  }

  @override
  Future<void> logoutUser() async {
    await Future.delayed(const Duration(seconds: 0));
    await apiService.logout();
  }

  @override
  Future<UserModel> getMeUser() async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.get('$baseUri/me');
    if (response.statusCode == 200) {
      user = UserModel.fromJson(response.data);
      return user;
    } else if (response.statusCode == 401) {
      return UserModel.empty();
    } else {
      throw Exception('Failed to get user');
    }
  }

  @override
  Future<UserModel> getOtherUser({required int userId}) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.get('$baseUri/$userId');
    if (response.statusCode == 200) {
      user = UserModel.fromJson(response.data);
      return user;
    } else if (response.statusCode == 401) {
      return UserModel.empty();
    } else {
      throw Exception('Failed to get user');
    }
  }

  @override
  Future<String> changePasswordUser({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.put(
      '$baseUri/$userId/change_password',
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );
    debugPrint('header: ${response.headers}');
    if (response.statusCode == 200) {
      return response.data['message'];
    } else if (response.statusCode == 401) {
      return response.data['detail'];
    } else if (response.statusCode == 404) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to change password');
    }
  }

  @override
  Future<String> updateUser({
    required int userId,
    required String verifyPassword,
    required String email,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    await Future.delayed(const Duration(seconds: 0));
    final response = await apiService.put(
      '$baseUri/update/$userId/$verifyPassword',
      data: {
        'email': email,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
      },
    );
    if (response.statusCode == 200) {
      return "User updated successfully";
    } else if (response.statusCode == 401) {
      debugPrint('response: ${response.data}');
      return response.data['detail'];
    } else if (response.statusCode == 404) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to update user');
    }
  }
}
