import 'package:autask/features/task/domain/usecases/add_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:autask/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:autask/features/task/presentation/cubit/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(
    this._getTasksUseCase,
    this._addTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(const TaskState());

  final GetTasksUseCase _getTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  Future<void> loadTasks() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final tasks = await _getTasksUseCase();
      emit(state.copyWith(tasks: tasks, isLoading: false));
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Gagal memuat data tugas',
        ),
      );
    }
  }

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    final trimmedTitle = title.trim();
    final trimmedDescription = description.trim();
    if (trimmedTitle.isEmpty) {
      emit(state.copyWith(errorMessage: 'Judul tugas tidak boleh kosong'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final tasks = await _addTaskUseCase(
        title: trimmedTitle,
        description: trimmedDescription,
      );
      emit(state.copyWith(tasks: tasks, isLoading: false));
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Gagal menambahkan tugas',
        ),
      );
    }
  }

  Future<void> deleteTask({required int id}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final tasks = await _deleteTaskUseCase(id: id);
      emit(state.copyWith(tasks: tasks, isLoading: false));
    } catch (_) {
      emit(
        state.copyWith(isLoading: false, errorMessage: 'Gagal menghapus tugas'),
      );
    }
  }
}
