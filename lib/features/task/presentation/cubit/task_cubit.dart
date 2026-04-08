import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/task/domain/entities/task.dart';
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
    emit(_toLoading());
    try {
      final tasks = await _getTasksUseCase();
      emit(
        _toLoaded(
          allTasks: tasks,
          statusFilter: state.statusFilter,
          sortOption: state.sortOption,
          searchQuery: state.searchQuery,
        ),
      );
    } catch (_) {
      emit(_toError(message: AppStrings.loadTaskError));
    }
  }

  Future<void> addTask({
    required String title,
    required String description,
    required String priority,
    DateTime? dueDate,
  }) async {
    final String trimmedTitle = title.trim();
    final String trimmedDescription = description.trim();
    if (trimmedTitle.isEmpty) {
      emit(_toError(message: AppStrings.emptyTitleError));
      return;
    }

    emit(_toLoading());
    try {
      final tasks = await _addTaskUseCase(
        title: trimmedTitle,
        description: trimmedDescription,
        priority: priority,
        dueDate: dueDate,
      );
      emit(
        _toLoaded(
          allTasks: tasks,
          statusFilter: state.statusFilter,
          sortOption: state.sortOption,
          searchQuery: state.searchQuery,
        ),
      );
    } catch (_) {
      emit(_toError(message: AppStrings.addTaskError));
    }
  }

  Future<void> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
    required String priority,
    DateTime? dueDate,
  }) async {
    final String trimmedTitle = title.trim();
    final String trimmedDescription = description.trim();
    if (trimmedTitle.isEmpty) {
      emit(_toError(message: AppStrings.emptyTitleError));
      return;
    }

    emit(_toLoading());
    try {
      final tasks = await _updateTaskUseCase(
        id: id,
        title: trimmedTitle,
        description: trimmedDescription,
        status: status,
        priority: priority,
        dueDate: dueDate,
      );
      emit(
        _toLoaded(
          allTasks: tasks,
          statusFilter: state.statusFilter,
          sortOption: state.sortOption,
          searchQuery: state.searchQuery,
        ),
      );
    } catch (_) {
      emit(_toError(message: AppStrings.updateTaskError));
    }
  }

  Future<void> quickUpdateTaskStatus({required Task task}) async {
    final String nextStatus = _nextStatus(currentStatus: task.status);
    await updateTask(
      id: task.id,
      title: task.title,
      description: task.description,
      status: nextStatus,
      priority: task.priority,
      dueDate: task.dueDate,
    );
  }

  Future<void> deleteTask({required int id}) async {
    emit(_toLoading());
    try {
      final tasks = await _deleteTaskUseCase(id: id);
      emit(
        _toLoaded(
          allTasks: tasks,
          statusFilter: state.statusFilter,
          sortOption: state.sortOption,
          searchQuery: state.searchQuery,
        ),
      );
    } catch (_) {
      emit(_toError(message: AppStrings.deleteTaskError));
    }
  }

  void setStatusFilter({required TaskStatusFilter statusFilter}) {
    emit(
      _toLoaded(
        allTasks: state.allTasks,
        statusFilter: statusFilter,
        sortOption: state.sortOption,
        searchQuery: state.searchQuery,
      ),
    );
  }

  void setSortOption({required TaskSortOption sortOption}) {
    emit(
      _toLoaded(
        allTasks: state.allTasks,
        statusFilter: state.statusFilter,
        sortOption: sortOption,
        searchQuery: state.searchQuery,
      ),
    );
  }

  void setSearchQuery({required String searchQuery}) {
    emit(
      _toLoaded(
        allTasks: state.allTasks,
        statusFilter: state.statusFilter,
        sortOption: state.sortOption,
        searchQuery: searchQuery,
      ),
    );
  }

  TaskLoading _toLoading() {
    return TaskLoading(
      allTasks: state.allTasks,
      tasks: state.tasks,
      statusFilter: state.statusFilter,
      sortOption: state.sortOption,
      searchQuery: state.searchQuery,
    );
  }

  TaskLoaded _toLoaded({
    required List<Task> allTasks,
    required TaskStatusFilter statusFilter,
    required TaskSortOption sortOption,
    required String searchQuery,
  }) {
    final List<Task> viewedTasks = _buildViewTasks(
      allTasks: allTasks,
      statusFilter: statusFilter,
      sortOption: sortOption,
      searchQuery: searchQuery,
    );

    return TaskLoaded(
      allTasks: allTasks,
      tasks: viewedTasks,
      statusFilter: statusFilter,
      sortOption: sortOption,
      searchQuery: searchQuery,
    );
  }

  TaskError _toError({required String message}) {
    return TaskError(
      allTasks: state.allTasks,
      tasks: state.tasks,
      statusFilter: state.statusFilter,
      sortOption: state.sortOption,
      searchQuery: state.searchQuery,
      message: message,
    );
  }

  List<Task> _buildViewTasks({
    required List<Task> allTasks,
    required TaskStatusFilter statusFilter,
    required TaskSortOption sortOption,
    required String searchQuery,
  }) {
    final String normalizedSearch = searchQuery.trim().toLowerCase();

    final Iterable<Task> filteredTasks = allTasks.where((Task task) {
      final bool statusMatch = switch (statusFilter) {
        TaskStatusFilter.all => true,
        TaskStatusFilter.todo => task.status == AppStrings.todoStatus,
        TaskStatusFilter.inProgress =>
          task.status == AppStrings.inProgressStatus,
        TaskStatusFilter.done => task.status == AppStrings.doneStatus,
      };

      if (!statusMatch) {
        return false;
      }

      if (normalizedSearch.isEmpty) {
        return true;
      }

      final String inTitle = task.title.toLowerCase();
      final String inDescription = task.description.toLowerCase();
      return inTitle.contains(normalizedSearch) ||
          inDescription.contains(normalizedSearch);
    });

    final List<Task> sortedTasks = filteredTasks.toList(growable: false);

    switch (sortOption) {
      case TaskSortOption.latestCreated:
        sortedTasks.sort((Task a, Task b) {
          final DateTime dateA =
              a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(a.id);
          final DateTime dateB =
              b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(b.id);
          return dateB.compareTo(dateA);
        });
        break;
      case TaskSortOption.highestPriority:
        sortedTasks.sort((Task a, Task b) {
          return _priorityRank(
            priority: a.priority,
          ).compareTo(_priorityRank(priority: b.priority));
        });
        break;
      case TaskSortOption.nearestDueDate:
        sortedTasks.sort((Task a, Task b) {
          final DateTime? dueA = a.dueDate;
          final DateTime? dueB = b.dueDate;

          if (dueA == null && dueB == null) {
            return 0;
          }
          if (dueA == null) {
            return 1;
          }
          if (dueB == null) {
            return -1;
          }
          return dueA.compareTo(dueB);
        });
        break;
    }

    return sortedTasks;
  }

  int _priorityRank({required String priority}) {
    switch (priority) {
      case AppStrings.highPriority:
        return 0;
      case AppStrings.mediumPriority:
        return 1;
      case AppStrings.lowPriority:
        return 2;
      default:
        return 3;
    }
  }

  String _nextStatus({required String currentStatus}) {
    switch (currentStatus) {
      case AppStrings.todoStatus:
        return AppStrings.inProgressStatus;
      case AppStrings.inProgressStatus:
        return AppStrings.doneStatus;
      default:
        return AppStrings.todoStatus;
    }
  }
}
