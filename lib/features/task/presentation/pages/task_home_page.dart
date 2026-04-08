import 'package:autask/app/theme/app_colors.dart';
import 'package:autask/app/theme/app_radius.dart';
import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/utils/date_formatter.dart';
import 'package:autask/features/task/domain/entities/task.dart';
import 'package:autask/features/task/presentation/cubit/task_cubit.dart';
import 'package:autask/features/task/presentation/cubit/task_state.dart';
import 'package:autask/features/task/presentation/pages/task_detail_page.dart';
import 'package:autask/features/task/presentation/widgets/task_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.taskPageTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BlocSelector<
              TaskCubit,
              TaskState,
              ({TaskStatusFilter filter, TaskSortOption sortOption})
            >(
              selector: (TaskState state) =>
                  (filter: state.statusFilter, sortOption: state.sortOption),
              builder:
                  (
                    BuildContext context,
                    ({TaskStatusFilter filter, TaskSortOption sortOption})
                    selected,
                  ) {
                    return _FilterSortSection(
                      selectedFilter: selected.filter,
                      selectedSortOption: selected.sortOption,
                      onFilterChanged: (TaskStatusFilter value) {
                        context.read<TaskCubit>().setStatusFilter(
                          statusFilter: value,
                        );
                      },
                      onSortChanged: (TaskSortOption value) {
                        context.read<TaskCubit>().setSortOption(
                          sortOption: value,
                        );
                      },
                    );
                  },
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              onChanged: (String value) {
                context.read<TaskCubit>().setSearchQuery(searchQuery: value);
              },
              decoration: InputDecoration(
                hintText: 'Cari tugas...',
                prefixIcon: const HeroIcon(
                  HeroIcons.magnifyingGlass,
                  style: HeroIconStyle.outline,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: BlocConsumer<TaskCubit, TaskState>(
                listener: (BuildContext context, TaskState state) {
                  if (state is TaskError) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                buildWhen: (TaskState previous, TaskState current) {
                  return previous.runtimeType != current.runtimeType ||
                      previous.tasks != current.tasks;
                },
                builder: (BuildContext context, TaskState state) {
                  if (state is TaskLoading && state.tasks.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.tasks.isEmpty) {
                    return const Center(
                      child: Text(AppStrings.emptyTaskMessage),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.tasks.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (BuildContext context, int index) {
                      final Task task = state.tasks[index];
                      final TaskCubit taskCubit = context.read<TaskCubit>();
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        child: Dismissible(
                          key: ValueKey<int>(task.id),
                          direction: DismissDirection.horizontal,
                          dismissThresholds: const <DismissDirection, double>{
                            DismissDirection.startToEnd: 0.2,
                            DismissDirection.endToStart: 0.2,
                          },
                          background: _SwipeActionBackground(
                            alignment: Alignment.centerLeft,
                            icon: HeroIcons.trash,
                            color: Colors.red.shade600,
                          ),
                          secondaryBackground: _SwipeActionBackground(
                            alignment: Alignment.centerRight,
                            icon: HeroIcons.pencilSquare,
                            color: AppColors.primary,
                          ),
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.endToStart) {
                              await _showEditTaskDialog(
                                context: context,
                                task: task,
                              );
                              return false;
                            }

                            return true;
                          },
                          onDismissed: (DismissDirection direction) {
                            if (direction == DismissDirection.startToEnd) {
                              taskCubit.deleteTask(id: task.id);
                            }
                          },
                          child: TaskListItem(
                            task: task,
                            onTap: () =>
                                _openTaskDetail(context: context, task: task),
                            onQuickStatus: () {
                              taskCubit.quickUpdateTaskStatus(task: task);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskDialog(context),
        icon: const HeroIcon(
          HeroIcons.plus,
          color: Colors.white,
          style: HeroIconStyle.outline,
        ),
        label: const Text(AppStrings.addTaskButton),
      ),
    );
  }

  void _openTaskDetail({required BuildContext context, required Task task}) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => TaskDetailPage(task: task)));
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final TaskCubit taskCubit = context.read<TaskCubit>();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String selectedPriority = AppStrings.mediumPriority;
    DateTime? selectedDueDate;

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext builderContext, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.modalSurface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xl,
              ),
              title: const Text(AppStrings.addTaskDialogTitle),
              titlePadding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Judul tugas',
                      ),
                      autofocus: true,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Deskripsi tugas',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _PriorityDropdown(
                      value: selectedPriority,
                      onChanged: (String value) {
                        setState(() {
                          selectedPriority = value;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _DueDatePickerField(
                      selectedDueDate: selectedDueDate,
                      onSelectDate: () async {
                        final DateTime? pickedDate = await _pickDueDate(
                          context: builderContext,
                          initialDate: selectedDueDate,
                        );
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          selectedDueDate = pickedDate;
                        });
                      },
                      onClearDate: () {
                        setState(() {
                          selectedDueDate = null;
                        });
                      },
                    ),
                    ],
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              actionsPadding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text(AppStrings.cancelLabel),
                ),
                FilledButton(
                  onPressed: () {
                    taskCubit.addTask(
                      title: titleController.text,
                      description: descriptionController.text,
                      priority: selectedPriority,
                      dueDate: selectedDueDate,
                    );
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text(AppStrings.saveLabel),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showEditTaskDialog({
    required BuildContext context,
    required Task task,
  }) async {
    final TaskCubit taskCubit = context.read<TaskCubit>();
    final TextEditingController titleController = TextEditingController(
      text: task.title,
    );
    final TextEditingController descriptionController = TextEditingController(
      text: task.description,
    );
    String selectedStatus = task.status;
    String selectedPriority = task.priority;
    DateTime? selectedDueDate = task.dueDate;

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext builderContext, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.modalSurface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xl,
              ),
              title: const Text(AppStrings.editTaskDialogTitle),
              titlePadding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Judul tugas',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Deskripsi tugas',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _StatusDropdown(
                      value: selectedStatus,
                      onChanged: (String value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _PriorityDropdown(
                      value: selectedPriority,
                      onChanged: (String value) {
                        setState(() {
                          selectedPriority = value;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _DueDatePickerField(
                      selectedDueDate: selectedDueDate,
                      onSelectDate: () async {
                        final DateTime? pickedDate = await _pickDueDate(
                          context: builderContext,
                          initialDate: selectedDueDate,
                        );
                        if (pickedDate == null) {
                          return;
                        }
                        setState(() {
                          selectedDueDate = pickedDate;
                        });
                      },
                      onClearDate: () {
                        setState(() {
                          selectedDueDate = null;
                        });
                      },
                    ),
                    ],
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              actionsPadding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text(AppStrings.cancelLabel),
                ),
                FilledButton(
                  onPressed: () {
                    taskCubit.updateTask(
                      id: task.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      status: selectedStatus,
                      priority: selectedPriority,
                      dueDate: selectedDueDate,
                    );
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text(AppStrings.saveLabel),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<DateTime?> _pickDueDate({
    required BuildContext context,
    required DateTime? initialDate,
  }) {
    final DateTime now = DateTime.now();
    return showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
      initialDate: initialDate ?? now,
    );
  }
}

class _FilterSortSection extends StatelessWidget {
  const _FilterSortSection({
    required this.selectedFilter,
    required this.selectedSortOption,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  final TaskStatusFilter selectedFilter;
  final TaskSortOption selectedSortOption;
  final ValueChanged<TaskStatusFilter> onFilterChanged;
  final ValueChanged<TaskSortOption> onSortChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: DropdownButtonFormField<TaskStatusFilter>(
            initialValue: selectedFilter,
            isExpanded: true,
            borderRadius: BorderRadius.circular(AppRadius.md),
            dropdownColor: AppColors.surface,
            elevation: 0,
            decoration: const InputDecoration(hintText: 'Filter status'),
            icon: const HeroIcon(
              HeroIcons.chevronDown,
              style: HeroIconStyle.outline,
            ),
            items: const <DropdownMenuItem<TaskStatusFilter>>[
              DropdownMenuItem<TaskStatusFilter>(
                value: TaskStatusFilter.all,
                child: Text('Semua Status'),
              ),
              DropdownMenuItem<TaskStatusFilter>(
                value: TaskStatusFilter.todo,
                child: Text('To Do'),
              ),
              DropdownMenuItem<TaskStatusFilter>(
                value: TaskStatusFilter.inProgress,
                child: Text('In Progress'),
              ),
              DropdownMenuItem<TaskStatusFilter>(
                value: TaskStatusFilter.done,
                child: Text('Done'),
              ),
            ],
            onChanged: (TaskStatusFilter? value) {
              if (value == null) {
                return;
              }
              onFilterChanged(value);
            },
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: DropdownButtonFormField<TaskSortOption>(
            initialValue: selectedSortOption,
            isExpanded: true,
            borderRadius: BorderRadius.circular(AppRadius.md),
            dropdownColor: AppColors.surface,
            elevation: 0,
            decoration: const InputDecoration(hintText: 'Urutkan'),
            icon: const HeroIcon(
              HeroIcons.chevronDown,
              style: HeroIconStyle.outline,
            ),
            items: const <DropdownMenuItem<TaskSortOption>>[
              DropdownMenuItem<TaskSortOption>(
                value: TaskSortOption.latestCreated,
                child: Text('Terbaru'),
              ),
              DropdownMenuItem<TaskSortOption>(
                value: TaskSortOption.highestPriority,
                child: Text('Prioritas Tertinggi'),
              ),
              DropdownMenuItem<TaskSortOption>(
                value: TaskSortOption.nearestDueDate,
                child: Text('Deadline Terdekat'),
              ),
            ],
            onChanged: (TaskSortOption? value) {
              if (value == null) {
                return;
              }
              onSortChanged(value);
            },
          ),
        ),
      ],
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      borderRadius: BorderRadius.circular(AppRadius.md),
      dropdownColor: AppColors.surface,
      elevation: 0,
      decoration: const InputDecoration(hintText: 'Status'),
      icon: const HeroIcon(
        HeroIcons.chevronDown,
        style: HeroIconStyle.outline,
      ),
      items: const <DropdownMenuItem<String>>[
        DropdownMenuItem<String>(
          value: AppStrings.todoStatus,
          child: Text('To Do'),
        ),
        DropdownMenuItem<String>(
          value: AppStrings.inProgressStatus,
          child: Text('In Progress'),
        ),
        DropdownMenuItem<String>(
          value: AppStrings.doneStatus,
          child: Text('Done'),
        ),
      ],
      onChanged: (String? changedValue) {
        if (changedValue == null) {
          return;
        }
        onChanged(changedValue);
      },
    );
  }
}

class _PriorityDropdown extends StatelessWidget {
  const _PriorityDropdown({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      borderRadius: BorderRadius.circular(AppRadius.md),
      dropdownColor: AppColors.surface,
      elevation: 0,
      decoration: const InputDecoration(hintText: 'Prioritas'),
      icon: const HeroIcon(
        HeroIcons.chevronDown,
        style: HeroIconStyle.outline,
      ),
      items: const <DropdownMenuItem<String>>[
        DropdownMenuItem<String>(
          value: AppStrings.highPriority,
          child: Text('Tinggi'),
        ),
        DropdownMenuItem<String>(
          value: AppStrings.mediumPriority,
          child: Text('Sedang'),
        ),
        DropdownMenuItem<String>(
          value: AppStrings.lowPriority,
          child: Text('Rendah'),
        ),
      ],
      onChanged: (String? changedValue) {
        if (changedValue == null) {
          return;
        }
        onChanged(changedValue);
      },
    );
  }
}

class _DueDatePickerField extends StatelessWidget {
  const _DueDatePickerField({
    required this.selectedDueDate,
    required this.onSelectDate,
    required this.onClearDate,
  });

  final DateTime? selectedDueDate;
  final VoidCallback onSelectDate;
  final VoidCallback onClearDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              selectedDueDate == null
                  ? AppStrings.noDueDateLabel
                  : DateFormatter.dmy(selectedDueDate!),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        IconButton(
          onPressed: onSelectDate,
          tooltip: AppStrings.chooseDateLabel,
          icon: const HeroIcon(
            HeroIcons.calendar,
            style: HeroIconStyle.outline,
          ),
        ),
        IconButton(
          onPressed: onClearDate,
          tooltip: AppStrings.clearDateLabel,
          icon: const HeroIcon(HeroIcons.xMark, style: HeroIconStyle.outline),
        ),
      ],
    );
  }
}

class _SwipeActionBackground extends StatelessWidget {
  const _SwipeActionBackground({
    required this.alignment,
    required this.icon,
    required this.color,
  });

  final Alignment alignment;
  final HeroIcons icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Container(
        width: 64,
        constraints: const BoxConstraints(minHeight: 56),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        alignment: Alignment.center,
        child: HeroIcon(
          icon,
          color: Colors.white,
          style: HeroIconStyle.outline,
        ),
      ),
    );
  }
}
