import 'package:equatable/equatable.dart';

class TaskDraft extends Equatable {
  const TaskDraft({
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    this.dueDate,
  });

  final String title;
  final String description;
  final String status;
  final String priority;
  final DateTime? dueDate;

  TaskDraft copyWith({
    String? title,
    String? description,
    String? status,
    String? priority,
    DateTime? dueDate,
    bool clearDueDate = false,
  }) {
    return TaskDraft(
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      dueDate: clearDueDate ? null : dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'due_date': dueDate?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => <Object?>[
    title,
    description,
    status,
    priority,
    dueDate,
  ];
}
