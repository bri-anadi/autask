abstract class AiAssistantRepository {
  Future<String> sendPrompt({required String apiKey, required String prompt});
}
