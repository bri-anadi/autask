import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/core/widgets/app_section_card.dart';
import 'package:autask/features/task/presentation/cubit/task_cubit.dart';
import 'package:autask/features/task/presentation/cubit/task_state.dart';
import 'package:autask/features/task/presentation/widgets/task_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            const AppSectionCard(
              title: AppStrings.appName,
              subtitle: AppStrings.taskPageSubtitle,
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: BlocConsumer<TaskCubit, TaskState>(
                listener: (BuildContext context, TaskState state) {
                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  }
                },
                builder: (BuildContext context, TaskState state) {
                  if (state.isLoading) {
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
                      final task = state.tasks[index];
                      return TaskListItem(
                        task: task,
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

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(AppStrings.addTaskDialogTitle),
          content: Column(
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
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(AppStrings.cancelLabel),
            ),
            FilledButton(
              onPressed: () {
                context.read<TaskCubit>().addTask(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                Navigator.of(dialogContext).pop();
              },
              child: const Text(AppStrings.saveLabel),
            ),
          ],
        );
      },
    );
  }
}
