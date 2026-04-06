import 'package:autask/features/task/domain/entities/task.dart';
import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({required this.task, required this.onDelete, super.key});

  final Task task;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(
          task.description.isEmpty ? '-' : task.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}
