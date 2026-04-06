import 'package:autask/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:autask/features/task/presentation/cubit/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._getTasksUseCase) : super(const TaskState());

  final GetTasksUseCase _getTasksUseCase;

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
}
