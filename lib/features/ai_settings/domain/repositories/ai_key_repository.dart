abstract class AiKeyRepository {
  Future<String?> readApiKey();
  Future<void> saveApiKey({required String apiKey});
  Future<void> deleteApiKey();
}
