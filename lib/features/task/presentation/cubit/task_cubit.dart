import 'package:autask/features/task/domain/usecases/add_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:autask/features/task/domain/usecases/update_task_usecase.dart';
import 'package:autask/features/task/presentation/cubit/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({
    required GetTasksUseCase getTasksUseCase,
    required AddTaskUseCase addTaskUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
  }) : _getTasksUseCase = getTasksUseCase,
       _addTaskUseCase = addTaskUseCase,
       _updateTaskUseCase = updateTaskUseCase,
       _deleteTaskUseCase = deleteTaskUseCase,
       super(const TaskInitial());

  final GetTasksUseCase _getTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  Future<void> loadTasks() async {
    emit(TaskLoading(tasks: state.tasks));
    try {
      final tasks = await _getTasksUseCase();
      emit(TaskLoaded(tasks: tasks));
    } catch (_) {
      emit(TaskError(tasks: state.tasks, message: 'Gagal memuat data tugas'));
    }
  }

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    final trimmedTitle = title.trim();
    final trimmedDescription = description.trim();
    if (trimmedTitle.isEmpty) {
      emit(
        TaskError(
          tasks: state.tasks,
          message: 'Judul tugas tidak boleh kosong',
        ),
      );
      return;
    }

    emit(TaskLoading(tasks: state.tasks));
    try {
      final tasks = await _addTaskUseCase(
        title: trimmedTitle,
        description: trimmedDescription,
      );
      emit(TaskLoaded(tasks: tasks));
    } catch (_) {
      emit(TaskError(tasks: state.tasks, message: 'Gagal menambahkan tugas'));
    }
  }

  Future<void> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
  }) async {
    final trimmedTitle = title.trim();
    final trimmedDescription = description.trim();
    if (trimmedTitle.isEmpty) {
      emit(
        TaskError(
          tasks: state.tasks,
          message: 'Judul tugas tidak boleh kosong',
        ),
      );
      return;
    }

    emit(TaskLoading(tasks: state.tasks));
    try {
      final tasks = await _updateTaskUseCase(
        id: id,
        title: trimmedTitle,
        description: trimmedDescription,
        status: status,
      );
      emit(TaskLoaded(tasks: tasks));
    } catch (_) {
      emit(TaskError(tasks: state.tasks, message: 'Gagal memperbarui tugas'));
    }
  }

  Future<void> deleteTask({required int id}) async {
    emit(TaskLoading(tasks: state.tasks));
    try {
      final tasks = await _deleteTaskUseCase(id: id);
      emit(TaskLoaded(tasks: tasks));
    } catch (_) {
      emit(TaskError(tasks: state.tasks, message: 'Gagal menghapus tugas'));
    }
  }
}
