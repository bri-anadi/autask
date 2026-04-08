import 'package:autask/features/task/data/datasources/task_database.dart';
import 'package:autask/features/task/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> addTask({
    required String title,
    required String description,
    required String priority,
    DateTime? dueDate,
  });
  Future<List<TaskModel>> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
    required String priority,
    DateTime? dueDate,
  });
  Future<List<TaskModel>> deleteTask({required int id});
}

class InMemoryTaskLocalDataSource implements TaskLocalDataSource {
  InMemoryTaskLocalDataSource();

  final List<TaskModel> _memoryStore = <TaskModel>[];

  @override
  Future<List<TaskModel>> getTasks() async {
    return List<TaskModel>.unmodifiable(_memoryStore);
  }

  @override
  Future<List<TaskModel>> addTask({
    required String title,
    required String description,
    required String priority,
    DateTime? dueDate,
  }) async {
    final now = DateTime.now();
    final TaskModel task = TaskModel(
      id: now.microsecondsSinceEpoch,
      title: title,
      description: description,
      status: 'todo',
      priority: priority,
      dueDate: dueDate,
      createdAt: now,
      updatedAt: now,
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
    required String priority,
    DateTime? dueDate,
  }) async {
    final int index = _memoryStore.indexWhere(
      (TaskModel task) => task.id == id,
    );
    if (index == -1) {
      return List<TaskModel>.unmodifiable(_memoryStore);
    }

    _memoryStore[index] = _memoryStore[index].copyWith(
      title: title,
      description: description,
      status: status,
      priority: priority,
      dueDate: dueDate,
      updatedAt: DateTime.now(),
    );
    return List<TaskModel>.unmodifiable(_memoryStore);
  }

  @override
  Future<List<TaskModel>> deleteTask({required int id}) async {
    _memoryStore.removeWhere((TaskModel task) => task.id == id);
    return List<TaskModel>.unmodifiable(_memoryStore);
  }
}

class SqfliteTaskLocalDataSource implements TaskLocalDataSource {
  SqfliteTaskLocalDataSource();

  @override
  Future<List<TaskModel>> getTasks() async {
    final Database db = await TaskDatabase.instance;
    final rows = await db.query(
      TaskDatabase.taskTable,
      orderBy: 'created_at DESC',
    );
    return rows
        .map((Map<String, Object?> row) => TaskModel.fromMap(row))
        .toList(growable: false);
  }

  @override
  Future<List<TaskModel>> addTask({
    required String title,
    required String description,
    required String priority,
    DateTime? dueDate,
  }) async {
    final Database db = await TaskDatabase.instance;
    final DateTime now = DateTime.now();
    await db.insert(TaskDatabase.taskTable, <String, Object?>{
      'title': title,
      'description': description,
      'status': 'todo',
      'priority': priority,
      'due_date': dueDate?.toIso8601String(),
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    });
    return getTasks();
  }

  @override
  Future<List<TaskModel>> updateTask({
    required int id,
    required String title,
    required String description,
    required String status,
    required String priority,
    DateTime? dueDate,
  }) async {
    final Database db = await TaskDatabase.instance;
    await db.update(
      TaskDatabase.taskTable,
      <String, Object?>{
        'title': title,
        'description': description,
        'status': status,
        'priority': priority,
        'due_date': dueDate?.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
    return getTasks();
  }

  @override
  Future<List<TaskModel>> deleteTask({required int id}) async {
    final Database db = await TaskDatabase.instance;
    await db.delete(
      TaskDatabase.taskTable,
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
    return getTasks();
  }
}
