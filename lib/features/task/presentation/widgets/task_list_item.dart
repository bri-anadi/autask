import 'package:autask/app/theme/app_colors.dart';
import 'package:autask/app/theme/app_radius.dart';
import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/utils/date_formatter.dart';
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: <Widget>[
                        _MetaInfoChip(
                          icon: HeroIcons.flag,
                          value: AppStrings.statusText(status: task.status),
                          color: _statusColor(status: task.status),
                        ),
                        _MetaInfoChip(
                          icon: HeroIcons.tag,
                          value: AppStrings.priorityText(
                            priority: task.priority,
                          ),
                          color: _priorityColor(priority: task.priority),
                        ),
                        _MetaInfoChip(
                          icon: HeroIcons.calendar,
                          value: _dueDateText(dueDate: task.dueDate),
                          color: _deadlineColor(dueDate: task.dueDate),
                        ),
                      ],
                    ),
                  ),
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

  String _dueDateText({required DateTime? dueDate}) {
    if (dueDate == null) {
      return '-';
    }
    return DateFormatter.dmy(dueDate);
  }
}

class _MetaInfoChip extends StatelessWidget {
  const _MetaInfoChip({
    required this.icon,
    required this.value,
    required this.color,
  });

  final HeroIcons icon;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HeroIcon(icon, color: color, size: 16, style: HeroIconStyle.outline),
          const SizedBox(width: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
