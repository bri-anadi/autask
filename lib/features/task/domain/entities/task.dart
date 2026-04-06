import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
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

  @override
  List<Object?> get props => <Object?>[id, title, description, status, dueDate];
}
