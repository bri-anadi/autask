import 'package:autask/features/ai_settings/domain/repositories/ai_key_repository.dart';

class SaveAiKeyUseCase {
  const SaveAiKeyUseCase(this._repository);

  final AiKeyRepository _repository;

  Future<void> call({required String apiKey}) {
    return _repository.saveApiKey(apiKey: apiKey);
  }
}
