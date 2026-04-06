import 'package:autask/features/task/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

class TaskState extends Equatable {
  const TaskState({
    this.tasks = const <Task>[],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<Task> tasks;
  final bool isLoading;
  final String? errorMessage;

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[tasks, isLoading, errorMessage];
}
