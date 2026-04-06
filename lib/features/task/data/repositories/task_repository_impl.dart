import 'package:autask/features/task/data/datasources/task_local_datasource.dart';
import 'package:autask/features/task/data/mappers/task_mapper.dart';
import 'package:autask/features/task/domain/entities/task.dart';
import 'package:autask/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this._localDataSource);

  final TaskLocalDataSource _localDataSource;

  @override
  Future<List<Task>> getTasks() async {
    final models = await _localDataSource.getTasks();
    return models.map(TaskMapper.toEntity).toList();
  }

  @override
  Future<List<Task>> addTask({
    required String title,
    required String description,
  }) async {
    final models = await _localDataSource.addTask(
      title: title,
      description: description,
    );
    return models.map(TaskMapper.toEntity).toList();
  }

  @override
  Future<List<Task>> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
  }) async {
    final models = await _localDataSource.updateTask(
      id: id,
      title: title,
      description: description,
      status: status,
    );
    return models.map(TaskMapper.toEntity).toList();
  }

  @override
  Future<List<Task>> deleteTask({required int id}) async {
    final models = await _localDataSource.deleteTask(id: id);
    return models.map(TaskMapper.toEntity).toList();
  }
}
