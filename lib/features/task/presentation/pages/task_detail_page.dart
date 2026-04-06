import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/utils/date_formatter.dart';
import 'package:autask/features/task/domain/entities/task.dart';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.taskDetailTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(task.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              task.description.isEmpty ? '-' : task.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            _InfoRow(label: AppStrings.statusLabel, value: task.status),
            const SizedBox(height: AppSpacing.sm),
            _InfoRow(
              label: AppStrings.dueDateLabel,
              value: task.dueDate == null
                  ? AppStrings.noDueDateLabel
                  : DateFormatter.dmy(task.dueDate!),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
