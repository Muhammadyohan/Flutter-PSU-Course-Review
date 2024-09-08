import 'package:flutter_psu_course_review/models/models.dart';

abstract class UserRepository {
  Future<void> createUser({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  });

  Future<void> loginUser({
    required String username,
    required String password,
  });

  Future<void> logoutUser();

  Future<UserModel> getMeUser();

  Future<UserModel> getOtherUser({required int userId});

  Future<void> changePasswordUser({
    required int userId,
    required String currentPassword,
    required String newPassword,
  });

  Future<void> updateUser({
    required int userId,
    required String verifyPassword,
    required String email,
    required String username,
    required String firstName,
    required String lastName,
  });
}
