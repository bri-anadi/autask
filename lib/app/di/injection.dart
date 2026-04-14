import 'package:autask/features/ai_assistant/data/datasources/ai_assistant_remote_datasource.dart';
import 'package:autask/features/ai_assistant/data/mappers/task_draft_parser.dart';
import 'package:autask/features/ai_assistant/data/repositories/ai_assistant_repository_impl.dart';
import 'package:autask/features/ai_assistant/domain/repositories/ai_assistant_repository.dart';
import 'package:autask/features/ai_assistant/domain/services/task_draft_extractor.dart';
import 'package:autask/features/ai_assistant/domain/usecases/build_task_draft_prompt_usecase.dart';
import 'package:autask/features/ai_assistant/domain/usecases/extract_task_draft_usecase.dart';
import 'package:autask/features/ai_assistant/domain/usecases/send_prompt_usecase.dart';
import 'package:autask/features/ai_assistant/presentation/cubit/ai_assistant_cubit.dart';
import 'package:autask/features/ai_settings/data/datasources/ai_key_local_datasource.dart';
import 'package:autask/features/ai_settings/data/repositories/ai_key_repository_impl.dart';
import 'package:autask/features/ai_settings/domain/repositories/ai_key_repository.dart';
import 'package:autask/features/ai_settings/domain/usecases/delete_ai_key_usecase.dart';
import 'package:autask/features/ai_settings/domain/usecases/read_ai_key_usecase.dart';
import 'package:autask/features/ai_settings/domain/usecases/save_ai_key_usecase.dart';
import 'package:autask/features/ai_settings/presentation/cubit/ai_settings_cubit.dart';
import 'package:autask/features/task/data/datasources/task_local_datasource.dart';
import 'package:autask/features/task/data/repositories/task_repository_impl.dart';
import 'package:autask/features/task/domain/repositories/task_repository.dart';
import 'package:autask/features/task/domain/usecases/add_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:autask/features/task/domain/usecases/update_task_usecase.dart';
import 'package:autask/features/task/presentation/cubit/task_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies({
  bool useInMemoryTaskDataSource = false,
  bool useInMemoryAiKeyDataSource = false,
  AiAssistantRemoteDataSource? aiAssistantRemoteDataSource,
}) async {
  await sl.reset();

  sl
    ..registerLazySingleton<AiKeyLocalDataSource>(
      () => useInMemoryAiKeyDataSource
          ? InMemoryAiKeyLocalDataSource()
          : SecureAiKeyLocalDataSource(),
    )
    ..registerLazySingleton<AiKeyRepository>(
      () => AiKeyRepositoryImpl(sl<AiKeyLocalDataSource>()),
    )
    ..registerLazySingleton<ReadAiKeyUseCase>(
      () => ReadAiKeyUseCase(sl<AiKeyRepository>()),
    )
    ..registerLazySingleton<SaveAiKeyUseCase>(
      () => SaveAiKeyUseCase(sl<AiKeyRepository>()),
    )
    ..registerLazySingleton<DeleteAiKeyUseCase>(
      () => DeleteAiKeyUseCase(sl<AiKeyRepository>()),
    )
    ..registerFactory<AiSettingsCubit>(
      () => AiSettingsCubit(
        readAiKeyUseCase: sl<ReadAiKeyUseCase>(),
        saveAiKeyUseCase: sl<SaveAiKeyUseCase>(),
        deleteAiKeyUseCase: sl<DeleteAiKeyUseCase>(),
      ),
    )
    ..registerLazySingleton<AiAssistantRemoteDataSource>(
      () => aiAssistantRemoteDataSource ?? GeminiAiAssistantRemoteDataSource(),
    )
    ..registerLazySingleton<AiAssistantRepository>(
      () => AiAssistantRepositoryImpl(sl<AiAssistantRemoteDataSource>()),
    )
    ..registerLazySingleton<TaskDraftExtractor>(() => const TaskDraftParser())
    ..registerLazySingleton<BuildTaskDraftPromptUseCase>(
      () => const BuildTaskDraftPromptUseCase(),
    )
    ..registerLazySingleton<ExtractTaskDraftUseCase>(
      () => ExtractTaskDraftUseCase(sl<TaskDraftExtractor>()),
    )
    ..registerLazySingleton<SendPromptUseCase>(
      () => SendPromptUseCase(sl<AiAssistantRepository>()),
    )
    ..registerFactory<AiAssistantCubit>(
      () => AiAssistantCubit(
        sendPromptUseCase: sl<SendPromptUseCase>(),
        buildTaskDraftPromptUseCase: sl<BuildTaskDraftPromptUseCase>(),
        extractTaskDraftUseCase: sl<ExtractTaskDraftUseCase>(),
        readAiKeyUseCase: sl<ReadAiKeyUseCase>(),
      ),
    )
    ..registerLazySingleton<TaskLocalDataSource>(
      () => useInMemoryTaskDataSource
          ? InMemoryTaskLocalDataSource()
          : SqfliteTaskLocalDataSource(),
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
    ..registerLazySingleton<UpdateTaskUseCase>(
      () => UpdateTaskUseCase(sl<TaskRepository>()),
    )
    ..registerFactory<TaskCubit>(
      () => TaskCubit(
        getTasksUseCase: sl<GetTasksUseCase>(),
        addTaskUseCase: sl<AddTaskUseCase>(),
        updateTaskUseCase: sl<UpdateTaskUseCase>(),
        deleteTaskUseCase: sl<DeleteTaskUseCase>(),
      ),
    );
}
