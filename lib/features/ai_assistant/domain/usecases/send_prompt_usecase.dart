import 'package:autask/features/ai_assistant/domain/repositories/ai_assistant_repository.dart';

class SendPromptUseCase {
  const SendPromptUseCase(this._repository);

  final AiAssistantRepository _repository;

  Future<String> call({required String apiKey, required String prompt}) {
    return _repository.sendPrompt(apiKey: apiKey, prompt: prompt);
  }
}
