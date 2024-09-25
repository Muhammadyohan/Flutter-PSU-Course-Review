sealed class UserEvent {}

class LoadUserEvent extends UserEvent {}

class LoadOtherUserEvent extends UserEvent {
  final int userId;
  LoadOtherUserEvent({required this.userId});
}

class CreateUserEvent extends UserEvent {
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String password;

  CreateUserEvent(
      {required this.email,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.password});
}

class LoginUserEvent extends UserEvent {
  final String username;
  final String password;
  LoginUserEvent({required this.username, required this.password});
}

class LogoutUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final int userId;
  final String verifyPassword;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  UpdateUserEvent(
      {required this.userId,
      required this.verifyPassword,
      required this.email,
      required this.username,
      required this.firstName,
      required this.lastName});
}

class ChangePasswordUserEvent extends UserEvent {
  final int userId;
  final String currentPassword;
  final String newPassword;
  ChangePasswordUserEvent(
      {required this.userId,
      required this.currentPassword,
      required this.newPassword});
}
