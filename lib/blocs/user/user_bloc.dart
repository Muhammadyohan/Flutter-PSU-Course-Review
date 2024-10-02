import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_psu_course_review/blocs/user/user_event.dart';
import 'package:flutter_psu_course_review/blocs/user/user_state.dart';
import 'package:flutter_psu_course_review/repositories/user/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(LoadingUserState()) {
    on<LoadUserEvent>(_onLoadedUser);
    on<LoadOtherUserEvent>(_onLoadedOtherUser);
    on<CreateUserEvent>(_onCreatedUser);
    on<LoginUserEvent>(_onLoginUser);
    on<LogoutUserEvent>(_onLogoutUser);
    on<UpdateUserEvent>(_onUpdatedUser);
    on<ChangePasswordUserEvent>(_onChengedPasswordUser);
  }

  _onLoadedUser(LoadUserEvent event, Emitter<UserState> emit) async {
    if (state is LoadingUserState) {
      try {
        debugPrint('LoadingUserState');
        final user = await userRepository.getMeUser();
        debugPrint('user: $user');
        emit(ReadyUserState(user: user));
      } catch (e) {
        debugPrint('Error: $e');
        emit(NeedLoginUserState(responseText: e.toString()));
      }
    }
  }

  _onLoadedOtherUser(LoadOtherUserEvent event, Emitter<UserState> emit) async {
    if (state is LoadingUserState) {
      final user = await userRepository.getOtherUser(userId: event.userId);
      emit(ReadyUserState(user: user));
    }
  }

  _onCreatedUser(CreateUserEvent event, Emitter<UserState> emit) async {
    debugPrint('Start create user');
    final response = await userRepository.createUser(
      email: event.email,
      username: event.username,
      firstName: event.firstName,
      lastName: event.lastName,
      password: event.password,
    );
    debugPrint('Finish create user');
    emit(NeedLoginUserState(responseText: response));
    add(LoginUserEvent(username: event.username, password: event.password));
  }

  _onLoginUser(LoginUserEvent event, Emitter<UserState> emit) async {
    if (state is NeedLoginUserState) {
      debugPrint('Start login user');
      final response = await userRepository.loginUser(
          username: event.username, password: event.password);
      debugPrint('response: $response');
      debugPrint('Finish login user');
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }

  _onLogoutUser(LogoutUserEvent event, Emitter<UserState> emit) async {
    await userRepository.logoutUser();
    emit(LoadingUserState());
  }

  _onUpdatedUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final response = await userRepository.updateUser(
        userId: event.userId,
        verifyPassword: event.verifyPassword,
        email: event.email,
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
      );
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }

  _onChengedPasswordUser(
      ChangePasswordUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final response = await userRepository.changePasswordUser(
        userId: event.userId,
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }
}
