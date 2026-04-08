import 'package:autask/features/ai_settings/data/datasources/ai_key_local_datasource.dart';
import 'package:autask/features/ai_settings/domain/repositories/ai_key_repository.dart';

class AiKeyRepositoryImpl implements AiKeyRepository {
  const AiKeyRepositoryImpl(this._localDataSource);

  final AiKeyLocalDataSource _localDataSource;

  @override
  Future<String?> readApiKey() {
    return _localDataSource.readApiKey();
  }

  @override
  Future<void> saveApiKey({required String apiKey}) {
    return _localDataSource.saveApiKey(apiKey: apiKey);
  }

  @override
  Future<void> deleteApiKey() {
    return _localDataSource.deleteApiKey();
  }
}
