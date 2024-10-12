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
          return bloc;
        }),
        BlocProvider<EventBloc>(create: (context) {
          final bloc = EventBloc(eventRepository: EventRepoFromDb());
          bloc.add(LoadEventsEvent());
          return bloc;
        })
      ],
      child: const MaterialApp(
        title: 'Flutter App',
        home: MainPage(),
      ),
    );
  }
}
