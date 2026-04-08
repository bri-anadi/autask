import 'package:autask/app/theme/app_colors.dart';
import 'package:autask/app/theme/app_radius.dart';
import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/task/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    required this.task,
    required this.onQuickStatus,
    required this.onTap,
    super.key,
  });

  final Task task;
  final VoidCallback onQuickStatus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
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
              Row(
                children: <Widget>[
                  _MetaIcon(
                    icon: HeroIcons.flag,
                    color: _statusColor(status: task.status),
                    tooltip: AppStrings.statusLabel,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _MetaIcon(
                    icon: HeroIcons.tag,
                    color: _priorityColor(priority: task.priority),
                    tooltip: AppStrings.priorityLabel,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _MetaIcon(
                    icon: HeroIcons.calendar,
                    color: _deadlineColor(dueDate: task.dueDate),
                    tooltip: AppStrings.dueDateLabel,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: AppStrings.quickStatusLabel,
                    onPressed: onQuickStatus,
                    icon: const HeroIcon(
                      HeroIcons.arrowPath,
                      style: HeroIconStyle.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor({required String status}) {
    if (status == AppStrings.doneStatus) {
      return Colors.green.shade600;
    }
    if (status == AppStrings.inProgressStatus) {
      return Colors.orange.shade700;
    }
    return AppColors.primaryDark;
  }

  Color _priorityColor({required String priority}) {
    if (priority == AppStrings.highPriority) {
      return Colors.red.shade600;
    }
    if (priority == AppStrings.mediumPriority) {
      return Colors.orange.shade700;
    }
    return AppColors.primaryDark;
  }

  Color _deadlineColor({required DateTime? dueDate}) {
    if (dueDate == null) {
      return AppColors.primaryDark;
    }

    final DateTime normalizedNow = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final DateTime normalizedDueDate = DateTime(
      dueDate.year,
      dueDate.month,
      dueDate.day,
    );

    if (normalizedDueDate.isBefore(normalizedNow)) {
      return Colors.red.shade600;
    }

    return AppColors.primaryDark;
  }
}

class _MetaIcon extends StatelessWidget {
  const _MetaIcon({
    required this.icon,
    required this.color,
    required this.tooltip,
  });

  final HeroIcons icon;
  final Color color;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: HeroIcon(icon, color: color, size: 18),
      ),
    );
  }
}
