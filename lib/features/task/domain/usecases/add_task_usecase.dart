import 'package:autask/features/task/domain/entities/task.dart';
import 'package:autask/features/task/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  const AddTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<List<Task>> call({
    required String title,
    required String description,
  }) {
    return _repository.addTask(title: title, description: description);
  }
}
