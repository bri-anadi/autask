import 'package:autask/app/theme/app_colors.dart';
import 'package:autask/app/theme/app_radius.dart';
import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/utils/date_formatter.dart';
import 'package:autask/features/task/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.taskDetailTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    task.description.isEmpty ? '-' : task.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _DetailMetaTile(
              icon: HeroIcons.flag,
              label: AppStrings.statusLabel,
              value: AppStrings.statusText(status: task.status),
            ),
            const SizedBox(height: AppSpacing.sm),
            _DetailMetaTile(
              icon: HeroIcons.tag,
              label: AppStrings.priorityLabel,
              value: AppStrings.priorityText(priority: task.priority),
            ),
            const SizedBox(height: AppSpacing.sm),
            _DetailMetaTile(
              icon: HeroIcons.calendar,
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

class _DetailMetaTile extends StatelessWidget {
  const _DetailMetaTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final HeroIcons icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            alignment: Alignment.center,
            child: HeroIcon(icon, size: 16, style: HeroIconStyle.outline),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
