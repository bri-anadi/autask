class TaskModel {
  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.dueDate,
  });

  final int id;
  final String title;
  final String description;
  final String status;
  final DateTime? dueDate;

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    DateTime? dueDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
