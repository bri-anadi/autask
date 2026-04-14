import 'package:autask/features/ai_assistant/data/datasources/ai_assistant_remote_datasource.dart';
import 'package:autask/features/ai_assistant/domain/repositories/ai_assistant_repository.dart';

class AiAssistantRepositoryImpl implements AiAssistantRepository {
  const AiAssistantRepositoryImpl(this._remoteDataSource);

  final AiAssistantRemoteDataSource _remoteDataSource;

  @override
  Future<String> sendPrompt({required String apiKey, required String prompt}) {
    return _remoteDataSource.sendPrompt(apiKey: apiKey, prompt: prompt);
  }
}
