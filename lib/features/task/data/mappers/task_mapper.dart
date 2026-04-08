import 'package:autask/features/task/data/models/task_model.dart';
import 'package:autask/features/task/domain/entities/task.dart';

class TaskMapper {
  const TaskMapper._();

  static Task toEntity(TaskModel model) {
    return Task(
      id: model.id,
      title: model.title,
      description: model.description,
      status: model.status,
      priority: model.priority,
      dueDate: model.dueDate,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
