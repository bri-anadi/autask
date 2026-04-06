import 'package:autask/features/task/domain/entities/task.dart';
import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    required this.task,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
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
