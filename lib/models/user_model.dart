import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String lastLoginDate;
  final String registerDate;
  final int id;

  const UserModel({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.lastLoginDate = '',
    this.registerDate = '',
    this.id = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      lastLoginDate: json['last_login_date'],
      registerDate: json['register_date'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'last_login_date': lastLoginDate,
      'register_date': registerDate,
      'id': id,
    };
  }

  factory UserModel.empty() {
    return const UserModel(
      email: '',
      username: '',
      firstName: '',
      lastName: '',
      lastLoginDate: '',
      registerDate: '',
      id: 0,
    );
  }

  @override
  List<Object?> get props =>
      [email, username, firstName, lastName, lastLoginDate, registerDate, id];
}
