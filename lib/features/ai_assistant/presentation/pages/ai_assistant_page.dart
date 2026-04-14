import 'package:autask/app/theme/app_colors.dart';
import 'package:autask/app/theme/app_radius.dart';
import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_assistant/domain/entities/ai_chat_message.dart';
import 'package:autask/features/ai_assistant/domain/entities/task_draft.dart';
import 'package:autask/features/ai_assistant/presentation/cubit/ai_assistant_cubit.dart';
import 'package:autask/features/ai_assistant/presentation/cubit/ai_assistant_state.dart';
import 'package:autask/features/task/presentation/cubit/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({super.key});

  @override
  State<AiAssistantPage> createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  late final TextEditingController _promptController;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.aiAssistantTitle)),
      body: BlocConsumer<AiAssistantCubit, AiAssistantState>(
        listener: (BuildContext context, AiAssistantState state) {
          if (state.status == AiAssistantStatus.error &&
              state.message != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message!)));
            context.read<AiAssistantCubit>().clearFeedback();
          }
        },
        builder: (BuildContext context, AiAssistantState state) {
          return Column(
            children: <Widget>[
              Expanded(
                child: state.messages.isEmpty
                    ? const Center(
                        child: Text(AppStrings.aiAssistantEmptyState),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        itemCount: state.messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final AiChatMessage message = state.messages[index];
                          return _ChatBubble(message: message);
                        },
                      ),
              ),
              if (state.status == AiAssistantStatus.loading)
                const Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Text(AppStrings.aiAssistantLoading),
                ),
              if (state.status != AiAssistantStatus.loading &&
                  state.latestRawResponse != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: _DraftExtractionIndicator(
                    isDraftDetected: state.latestDraft != null,
                  ),
                ),
              if (state.latestDraft != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            _openDraftConfirmationSheet(
                              context: context,
                              draft: state.latestDraft!,
                            );
                          },
                          icon: const HeroIcon(
                            HeroIcons.documentCheck,
                            style: HeroIconStyle.outline,
                            color: Colors.white,
                          ),
                          label: const Text(
                            AppStrings.aiAssistantReviewDraftButton,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.xs,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                color: AppColors.background,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        key: const Key('ai_assistant_input'),
                        controller: _promptController,
                        decoration: const InputDecoration(
                          hintText: AppStrings.aiAssistantInputHint,
                        ),
                        minLines: 1,
                        maxLines: 4,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    FilledButton(
                      key: const Key('ai_assistant_send_button'),
                      onPressed: state.status == AiAssistantStatus.loading
                          ? null
                          : () {
                              final String prompt = _promptController.text;
                              _promptController.clear();
                              context.read<AiAssistantCubit>().sendPrompt(
                                prompt: prompt,
                              );
                            },
                      child: const HeroIcon(
                        HeroIcons.paperAirplane,
                        color: Colors.white,
                        style: HeroIconStyle.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openDraftConfirmationSheet({
    required BuildContext context,
    required TaskDraft draft,
  }) async {
    final TextEditingController titleController = TextEditingController(
      text: draft.title,
    );
    final TextEditingController descriptionController = TextEditingController(
      text: draft.description,
    );
    String selectedPriority = draft.priority;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.modalSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext builderContext, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                MediaQuery.of(builderContext).viewInsets.bottom + AppSpacing.md,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    AppStrings.aiAssistantConfirmSheetTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Judul tugas'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Deskripsi tugas',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<String>(
                    initialValue: selectedPriority,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    dropdownColor: AppColors.surface,
                    elevation: 0,
                    decoration: const InputDecoration(hintText: 'Prioritas'),
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
                    onChanged: (String? value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectedPriority = value;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: () async {
                      await context.read<TaskCubit>().addTask(
                        title: titleController.text,
                        description: descriptionController.text,
                        priority: selectedPriority,
                        dueDate: draft.dueDate,
                      );
                      if (!builderContext.mounted) {
                        return;
                      }
                      builderContext
                          .read<AiAssistantCubit>()
                          .clearLatestExtraction();
                      Navigator.of(builderContext).pop();
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              AppStrings.aiAssistantSaveDraftSuccess,
                            ),
                          ),
                        );
                    },
                    child: const Text(AppStrings.aiAssistantSaveDraftButton),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    titleController.dispose();
    descriptionController.dispose();
  }
}

class _DraftExtractionIndicator extends StatelessWidget {
  const _DraftExtractionIndicator({required this.isDraftDetected});

  final bool isDraftDetected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: <Widget>[
          HeroIcon(
            isDraftDetected
                ? HeroIcons.checkCircle
                : HeroIcons.exclamationCircle,
            style: HeroIconStyle.outline,
            size: 18,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              isDraftDetected
                  ? AppStrings.aiAssistantDraftReady
                  : AppStrings.aiAssistantDraftFallback,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final AiChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.role == AiChatRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Text(
          message.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isUser ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
