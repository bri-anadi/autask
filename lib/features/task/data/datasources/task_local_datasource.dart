import 'package:autask/features/task/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> addTask({
    required String title,
    required String description,
  });
  Future<List<TaskModel>> deleteTask(int id);
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
  Future<List<TaskModel>> deleteTask(int id) async {
    _memoryStore.removeWhere((TaskModel task) => task.id == id);
    return List<TaskModel>.unmodifiable(_memoryStore);
  }
}
