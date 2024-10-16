import 'package:flutter_psu_course_review/models/models.dart';

sealed class UserState {
  final UserModel user;
  final String responseText;
  UserState({required this.user, this.responseText = ''});
}

class LoadingUserState extends UserState {
  LoadingUserState({super.responseText}) : super(user: UserModel.empty());
}

class NeedLoginUserState extends UserState {
  NeedLoginUserState({super.responseText}) : super(user: UserModel.empty());
}

class ReadyUserState extends UserState {
  ReadyUserState({required super.user});
}

class ErrorUserState extends UserState {
  ErrorUserState({super.responseText})
      : super(user: UserModel.empty());
}
