import 'package:autask/features/ai_settings/domain/repositories/ai_key_repository.dart';

class DeleteAiKeyUseCase {
  const DeleteAiKeyUseCase(this._repository);

  final AiKeyRepository _repository;

  Future<void> call() {
    return _repository.deleteApiKey();
  }
}
