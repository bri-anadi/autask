import 'package:autask/features/task/domain/entities/task.dart';
import 'package:autask/features/task/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  const UpdateTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<List<Task>> call({
    required int id,
    required String title,
    required String description,
    required String status,
  }) {
    return _repository.updateTask(
      id: id,
      title: title,
      description: description,
      status: status,
    );
  }
}
