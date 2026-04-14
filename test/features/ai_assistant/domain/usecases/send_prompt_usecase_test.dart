import 'package:autask/features/ai_assistant/domain/repositories/ai_assistant_repository.dart';
import 'package:autask/features/ai_assistant/domain/usecases/send_prompt_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAiAssistantRepository implements AiAssistantRepository {
  _FakeAiAssistantRepository({required this.response});

  final String response;
  String? lastApiKey;
  String? lastPrompt;

  @override
  Future<String> sendPrompt({
    required String apiKey,
    required String prompt,
  }) async {
    lastApiKey = apiKey;
    lastPrompt = prompt;
    return response;
  }
}

void main() {
  test('SendPromptUseCase forwards api key and prompt to repository', () async {
    final _FakeAiAssistantRepository repository = _FakeAiAssistantRepository(
      response: 'ok',
    );
    final SendPromptUseCase useCase = SendPromptUseCase(repository);

    final String result = await useCase(apiKey: 'AIza_test', prompt: 'hello');

    expect(result, 'ok');
    expect(repository.lastApiKey, 'AIza_test');
    expect(repository.lastPrompt, 'hello');
  });
}
