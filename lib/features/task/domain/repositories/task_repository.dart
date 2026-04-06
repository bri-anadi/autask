import 'package:autask/features/task/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<List<Task>> addTask({
    required String title,
    required String description,
  });
  Future<List<Task>> deleteTask({required int id});
}
