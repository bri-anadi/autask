import 'package:autask/features/task/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  const TaskLocalDataSourceImpl();

  @override
  Future<List<TaskModel>> getTasks() async {
    return const <TaskModel>[];
  }
}
