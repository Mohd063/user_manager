import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_me/logic/user/user_bloc.dart';
import 'package:manage_me/logic/user/user_event.dart';
import 'package:manage_me/logic/todo/todo_bloc.dart';
import 'package:manage_me/logic/post/post_bloc.dart';
import 'package:manage_me/data/repositories/user_repository.dart';
import 'package:manage_me/data/repositories/api/user_api_repo.dart';
import 'package:manage_me/data/repositories/api/todo_api_repo.dart';
import 'package:manage_me/data/repositories/api/post_api_repo.dart'; // Assuming this exists
import 'package:manage_me/presentation/screens/splash_screen.dart';
import 'package:manage_me/themes/tcubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // ThemeCubit to manage app-wide theme (light/dark)
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),

        // UserBloc to manage user-related state, initialized with UserRepository
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(UserRepository(UserApiRepo()))..add(FetchUsers()),
        ),

        // TodoBloc to manage todo-related state, initialized with TodoApiRepo
        BlocProvider<TodoBloc>(
          create: (_) => TodoBloc(TodoApiRepo()),
        ),

        // PostBloc to manage posts, initialized with PostApiRepo (assumed)
        BlocProvider<PostBloc>(
          create: (_) => PostBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to ThemeCubit state and rebuild MaterialApp when theme changes
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp(
          title: 'Manage Me',
          debugShowCheckedModeBanner: false,
          theme: theme,  // Apply current theme (light or dark)
          home: const OnboardingScreen(), // Your app's first screen
        );
      },
    );
  }
}
