import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';
import 'package:flutter_psu_course_review/repositories/repositories.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) {
          final bloc = UserBloc(userRepository: UserRepoFromDb());
          bloc.add(LoadUserEvent());
          return bloc;
        })
      ],
      child: const MaterialApp(
        title: 'Flutter App',
        home: WelcomePage(), // Set the WelcomePage as the initial page
      ),
    );
  }
}
