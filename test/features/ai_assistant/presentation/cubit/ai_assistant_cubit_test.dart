import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_assistant/domain/repositories/ai_assistant_repository.dart';
import 'package:autask/features/ai_assistant/domain/usecases/send_prompt_usecase.dart';
import 'package:autask/features/ai_assistant/presentation/cubit/ai_assistant_cubit.dart';
import 'package:autask/features/ai_assistant/presentation/cubit/ai_assistant_state.dart';
import 'package:autask/features/ai_settings/domain/repositories/ai_key_repository.dart';
import 'package:autask/features/ai_settings/domain/usecases/read_ai_key_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAiAssistantRepository implements AiAssistantRepository {
  _FakeAiAssistantRepository({required this.response});

  final String response;

  @override
  Future<String> sendPrompt({
    required String apiKey,
    required String prompt,
  }) async {
    return response;
  }
}

class _FakeAiKeyRepository implements AiKeyRepository {
  _FakeAiKeyRepository({this.savedKey});

  final String? savedKey;

  @override
  Future<void> deleteApiKey() async {}

  @override
  Future<String?> readApiKey() async => savedKey;

  @override
  Future<void> saveApiKey({required String apiKey}) async {}
}

void main() {
  blocTest<AiAssistantCubit, AiAssistantState>(
    'emits loading then loaded with messages when prompt success',
    build: () {
      return AiAssistantCubit(
        sendPromptUseCase: SendPromptUseCase(
          _FakeAiAssistantRepository(response: 'draft task'),
        ),
        readAiKeyUseCase: ReadAiKeyUseCase(
          _FakeAiKeyRepository(savedKey: 'AIza_valid_key_1234567890'),
        ),
      );
    },
    act: (AiAssistantCubit cubit) => cubit.sendPrompt(prompt: 'buat tugas'),
    expect: () => <dynamic>[
      isA<AiAssistantState>().having(
        (AiAssistantState state) => state.status,
        'status',
        AiAssistantStatus.loading,
      ),
      isA<AiAssistantState>()
          .having(
            (AiAssistantState state) => state.status,
            'status',
            AiAssistantStatus.loaded,
          )
          .having(
            (AiAssistantState state) => state.messages.length,
            'messages length',
            2,
          ),
    ],
  );

  blocTest<AiAssistantCubit, AiAssistantState>(
    'emits error when api key is missing',
    build: () {
      return AiAssistantCubit(
        sendPromptUseCase: SendPromptUseCase(
          _FakeAiAssistantRepository(response: 'ignored'),
        ),
        readAiKeyUseCase: ReadAiKeyUseCase(
          _FakeAiKeyRepository(savedKey: null),
        ),
      );
    },
    act: (AiAssistantCubit cubit) => cubit.sendPrompt(prompt: 'buat tugas'),
    expect: () => <dynamic>[
      isA<AiAssistantState>().having(
        (AiAssistantState state) => state.status,
        'status',
        AiAssistantStatus.loading,
      ),
      isA<AiAssistantState>()
          .having(
            (AiAssistantState state) => state.status,
            'status',
            AiAssistantStatus.error,
          )
          .having(
            (AiAssistantState state) => state.message,
            'message',
            AppStrings.aiMissingKeyError,
          ),
    ],
  );
}
