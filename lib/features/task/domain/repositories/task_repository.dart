import 'package:autask/features/task/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<List<Task>> addTask({
    required String title,
    required String description,
  });
  Future<List<Task>> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
  });
  Future<List<Task>> deleteTask({required int id});
}
