import 'package:autask/features/task/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

enum TaskStatusFilter { all, todo, inProgress, done }

enum TaskSortOption { latestCreated, highestPriority, nearestDueDate }

abstract class TaskState extends Equatable {
  const TaskState({
    required this.allTasks,
    required this.tasks,
    required this.statusFilter,
    required this.sortOption,
  });

  final List<Task> allTasks;
  final List<Task> tasks;
  final TaskStatusFilter statusFilter;
  final TaskSortOption sortOption;

  @override
  List<Object?> get props => <Object?>[
    allTasks,
    tasks,
    statusFilter,
    sortOption,
  ];
}

class TaskInitial extends TaskState {
  const TaskInitial()
    : super(
        allTasks: const <Task>[],
        tasks: const <Task>[],
        statusFilter: TaskStatusFilter.all,
        sortOption: TaskSortOption.latestCreated,
      );
}

class TaskLoading extends TaskState {
  const TaskLoading({
    required super.allTasks,
    required super.tasks,
    required super.statusFilter,
    required super.sortOption,
  });
}

class TaskLoaded extends TaskState {
  const TaskLoaded({
    required super.allTasks,
    required super.tasks,
    required super.statusFilter,
    required super.sortOption,
  });
}

class TaskError extends TaskState {
  const TaskError({
    required super.allTasks,
    required super.tasks,
    required super.statusFilter,
    required super.sortOption,
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => <Object?>[
    allTasks,
    tasks,
    statusFilter,
    sortOption,
    message,
  ];
}
