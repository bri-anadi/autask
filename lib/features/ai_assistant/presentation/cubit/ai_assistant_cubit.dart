import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_assistant/data/datasources/ai_assistant_remote_datasource.dart';
import 'package:autask/features/ai_assistant/domain/entities/ai_chat_message.dart';
import 'package:autask/features/ai_assistant/domain/entities/task_draft.dart';
import 'package:autask/features/ai_assistant/domain/usecases/build_task_draft_prompt_usecase.dart';
import 'package:autask/features/ai_assistant/domain/usecases/extract_task_draft_usecase.dart';
import 'package:autask/features/ai_assistant/domain/usecases/send_prompt_usecase.dart';
import 'package:autask/features/ai_assistant/presentation/cubit/ai_assistant_state.dart';
import 'package:autask/features/ai_settings/domain/usecases/read_ai_key_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiAssistantCubit extends Cubit<AiAssistantState> {
  AiAssistantCubit({
    required SendPromptUseCase sendPromptUseCase,
    required BuildTaskDraftPromptUseCase buildTaskDraftPromptUseCase,
    required ExtractTaskDraftUseCase extractTaskDraftUseCase,
    required ReadAiKeyUseCase readAiKeyUseCase,
  }) : _sendPromptUseCase = sendPromptUseCase,
       _buildTaskDraftPromptUseCase = buildTaskDraftPromptUseCase,
       _extractTaskDraftUseCase = extractTaskDraftUseCase,
       _readAiKeyUseCase = readAiKeyUseCase,
       super(const AiAssistantState.initial());

  final SendPromptUseCase _sendPromptUseCase;
  final BuildTaskDraftPromptUseCase _buildTaskDraftPromptUseCase;
  final ExtractTaskDraftUseCase _extractTaskDraftUseCase;
  final ReadAiKeyUseCase _readAiKeyUseCase;

  Future<void> sendPrompt({required String prompt}) async {
    final String sanitizedPrompt = prompt.trim();
    if (sanitizedPrompt.isEmpty) {
      emit(
        state.copyWith(
          status: AiAssistantStatus.error,
          message: AppStrings.aiPromptEmptyError,
        ),
      );
      return;
    }

    emit(state.copyWith(status: AiAssistantStatus.loading, message: null));

    final String? apiKey = await _readAiKeyUseCase();
    if (apiKey == null || apiKey.trim().isEmpty) {
      emit(
        state.copyWith(
          status: AiAssistantStatus.error,
          message: AppStrings.aiMissingKeyError,
        ),
      );
      return;
    }

    try {
      final String promptTemplate = _buildTaskDraftPromptUseCase(
        userPrompt: sanitizedPrompt,
      );
      final String response = await _sendPromptUseCase(
        apiKey: apiKey,
        prompt: promptTemplate,
      );
      final TaskDraft? latestDraft = _tryExtractTaskDraft(response: response);

      final List<AiChatMessage> nextMessages = <AiChatMessage>[
        ...state.messages,
        AiChatMessage(
          role: AiChatRole.user,
          text: sanitizedPrompt,
          createdAt: DateTime.now(),
        ),
        AiChatMessage(
          role: AiChatRole.assistant,
          text: response,
          createdAt: DateTime.now(),
        ),
      ];

      emit(
        state.copyWith(
          status: AiAssistantStatus.loaded,
          messages: nextMessages,
          message: null,
          latestDraft: latestDraft,
          latestRawResponse: response,
        ),
      );
    } on AiAssistantRequestException catch (error) {
      emit(
        state.copyWith(status: AiAssistantStatus.error, message: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AiAssistantStatus.error,
          message: AppStrings.aiGenericError,
        ),
      );
    }
  }

  void clearFeedback() {
    if (state.message == null && state.status != AiAssistantStatus.error) {
      return;
    }

    emit(state.copyWith(status: AiAssistantStatus.loaded, message: null));
  }

  void clearLatestExtraction() {
    emit(state.copyWith(latestDraft: null, latestRawResponse: null));
  }

  TaskDraft? _tryExtractTaskDraft({required String response}) {
    try {
      return _extractTaskDraftUseCase(responseText: response);
    } catch (_) {
      return null;
    }
  }
}
