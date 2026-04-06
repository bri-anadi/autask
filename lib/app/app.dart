import 'package:autask/app/di/injection.dart';
import 'package:autask/app/theme/app_theme.dart';
import 'package:autask/features/task/presentation/cubit/task_cubit.dart';
import 'package:autask/features/task/presentation/pages/task_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutaskApp extends StatelessWidget {
  const AutaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autask',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: BlocProvider<TaskCubit>(
        create: (_) => sl<TaskCubit>()..loadTasks(),
        child: const TaskHomePage(),
      ),
    );
  }
}
