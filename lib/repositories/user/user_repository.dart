import 'package:flutter_psu_course_review/models/models.dart';

abstract class UserRepository {
  Future<String> createUser({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  });

  Future<String> loginUser({
    required String username,
    required String password,
  });

  Future<void> logoutUser();

  Future<UserModel> getMeUser();

  Future<UserModel> getOtherUser({required int userId});

  Future<String> changePasswordUser({
    required int userId,
    required String currentPassword,
    required String newPassword,
  });

  Future<String> updateUser({
    required int userId,
    required String verifyPassword,
    required String email,
    required String username,
    required String firstName,
    required String lastName,
  });
}
