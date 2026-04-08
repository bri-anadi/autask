import 'package:autask/app/theme/app_radius.dart';
import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/utils/date_formatter.dart';
import 'package:autask/features/task/domain/entities/task.dart';
import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    required this.task,
    required this.onDelete,
    required this.onEdit,
    required this.onQuickStatus,
    required this.onTap,
    super.key,
  });

  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onQuickStatus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String statusText = AppStrings.statusText(status: task.status);
    final String priorityText = AppStrings.priorityText(
      priority: task.priority,
    );
    final String dueDateText = task.dueDate == null
        ? AppStrings.noDueDateLabel
        : DateFormatter.dmy(task.dueDate!);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(task.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                task.description.isEmpty ? '-' : task.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: <Widget>[
                  _InfoChip(
                    label: '${AppStrings.statusLabel}: $statusText',
                    icon: Icons.flag_outlined,
                  ),
                  _InfoChip(
                    label: '${AppStrings.priorityLabel}: $priorityText',
                    icon: Icons.keyboard_double_arrow_up,
                  ),
                  _InfoChip(
                    label: '${AppStrings.dueDateLabel}: $dueDateText',
                    icon: Icons.calendar_today_outlined,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    tooltip: AppStrings.editTaskLabel,
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: AppStrings.quickStatusLabel,
                    onPressed: onQuickStatus,
                    icon: const Icon(Icons.autorenew_outlined),
                  ),
                  IconButton(
                    tooltip: AppStrings.deleteTaskLabel,
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}
