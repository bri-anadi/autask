import 'package:autask/features/ai_settings/domain/repositories/ai_key_repository.dart';

class ReadAiKeyUseCase {
  const ReadAiKeyUseCase(this._repository);

  final AiKeyRepository _repository;

  Future<String?> call() {
    return _repository.readApiKey();
  }
}
