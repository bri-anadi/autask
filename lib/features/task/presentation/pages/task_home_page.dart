import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/app/di/injection.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/utils/date_formatter.dart';
import 'package:autask/core/widgets/app_section_card.dart';
import 'package:autask/features/ai_settings/presentation/cubit/ai_settings_cubit.dart';
import 'package:autask/features/ai_settings/presentation/pages/ai_settings_page.dart';
import 'package:autask/features/task/domain/entities/task.dart';
import 'package:autask/features/task/presentation/cubit/task_cubit.dart';
import 'package:autask/features/task/presentation/cubit/task_state.dart';
import 'package:autask/features/task/presentation/pages/task_detail_page.dart';
import 'package:autask/features/task/presentation/widgets/task_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.taskPageTitle),
        actions: <Widget>[
          IconButton(
            tooltip: AppStrings.aiSettingsLabel,
            onPressed: () {
              _openAiSettings(context: context);
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AppSectionCard(
              title: AppStrings.appName,
              subtitle: AppStrings.taskPageSubtitle,
            ),
            const SizedBox(height: AppSpacing.md),
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
                      return TaskListItem(
                        task: task,
                        onTap: () =>
                            _openTaskDetail(context: context, task: task),
                        onEdit: () =>
                            _showEditTaskDialog(context: context, task: task),
                        onQuickStatus: () {
                          context.read<TaskCubit>().quickUpdateTaskStatus(
                            task: task,
                          );
                        },
                        onDelete: () =>
                            context.read<TaskCubit>().deleteTask(id: task.id),
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
        icon: const Icon(Icons.add),
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
              title: const Text(AppStrings.addTaskDialogTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.titleLabel,
                      ),
                      autofocus: true,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.descriptionLabel,
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
              title: const Text(AppStrings.editTaskDialogTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.titleLabel,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.descriptionLabel,
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

  void _openAiSettings({required BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<AiSettingsCubit>(
          create: (_) => sl<AiSettingsCubit>()..loadSavedKey(),
          child: const AiSettingsPage(),
        ),
      ),
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
            decoration: const InputDecoration(
              labelText: AppStrings.filterLabel,
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
            decoration: const InputDecoration(labelText: AppStrings.sortLabel),
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
      decoration: const InputDecoration(labelText: AppStrings.statusLabel),
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
      decoration: const InputDecoration(labelText: AppStrings.priorityLabel),
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
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: AppStrings.dueDateLabel,
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
          icon: const Icon(Icons.calendar_month_outlined),
        ),
        IconButton(
          onPressed: onClearDate,
          tooltip: AppStrings.clearDateLabel,
          icon: const Icon(Icons.clear_outlined),
        ),
      ],
    );
  }
}
