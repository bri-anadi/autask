import 'package:autask/features/task/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> addTask({
    required String title,
    required String description,
  });
  Future<List<TaskModel>> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
  });
  Future<List<TaskModel>> deleteTask({required int id});
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  const TaskLocalDataSourceImpl();

  static final List<TaskModel> _memoryStore = <TaskModel>[];

  @override
  Future<List<TaskModel>> getTasks() async {
    return List<TaskModel>.unmodifiable(_memoryStore);
  }

  @override
  Future<List<TaskModel>> addTask({
    required String title,
    required String description,
  }) async {
    final TaskModel task = TaskModel(
      id: DateTime.now().microsecondsSinceEpoch,
      title: title,
      description: description,
      status: 'todo',
    );
    _memoryStore.insert(0, task);
    return List<TaskModel>.unmodifiable(_memoryStore);
  }

  @override
  Future<List<TaskModel>> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
  }) async {
    final int index = _memoryStore.indexWhere(
      (TaskModel task) => task.id == id,
    );
    if (index == -1) {
      return List<TaskModel>.unmodifiable(_memoryStore);
    }

    final TaskModel oldTask = _memoryStore[index];
    _memoryStore[index] = oldTask.copyWith(
      title: title,
      description: description,
      status: status,
    );
    return List<TaskModel>.unmodifiable(_memoryStore);
  }

  @override
  Future<List<TaskModel>> deleteTask({required int id}) async {
    _memoryStore.removeWhere((TaskModel task) => task.id == id);
    return List<TaskModel>.unmodifiable(_memoryStore);
  }
}
