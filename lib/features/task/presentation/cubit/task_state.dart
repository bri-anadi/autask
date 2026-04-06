import 'package:autask/features/task/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable {
  const TaskState({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object?> get props => <Object?>[tasks];
}

class TaskInitial extends TaskState {
  const TaskInitial() : super(tasks: const <Task>[]);
}

class TaskLoading extends TaskState {
  const TaskLoading({required super.tasks});
}

class TaskLoaded extends TaskState {
  const TaskLoaded({required super.tasks});
}

class TaskError extends TaskState {
  const TaskError({required super.tasks, required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[tasks, message];
}
