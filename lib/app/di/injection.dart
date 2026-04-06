import 'package:autask/features/task/data/datasources/task_local_datasource.dart';
import 'package:autask/features/task/data/repositories/task_repository_impl.dart';
import 'package:autask/features/task/domain/repositories/task_repository.dart';
import 'package:autask/features/task/domain/usecases/add_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:autask/features/task/presentation/cubit/task_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  sl
    ..registerLazySingleton<TaskLocalDataSource>(
      () => const TaskLocalDataSourceImpl(),
    )
    ..registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(sl<TaskLocalDataSource>()),
    )
    ..registerLazySingleton<GetTasksUseCase>(
      () => GetTasksUseCase(sl<TaskRepository>()),
    )
    ..registerLazySingleton<AddTaskUseCase>(
      () => AddTaskUseCase(sl<TaskRepository>()),
    )
    ..registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(sl<TaskRepository>()),
    )
    ..registerFactory<TaskCubit>(
      () => TaskCubit(
        sl<GetTasksUseCase>(),
        sl<AddTaskUseCase>(),
        sl<DeleteTaskUseCase>(),
      ),
    );
}
