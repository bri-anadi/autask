import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AiKeyLocalDataSource {
  Future<String?> readApiKey();
  Future<void> saveApiKey({required String apiKey});
  Future<void> deleteApiKey();
}

class SecureAiKeyLocalDataSource implements AiKeyLocalDataSource {
  SecureAiKeyLocalDataSource({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const String keyGeminiApiKey = 'gemini_api_key';

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> readApiKey() {
    return _secureStorage.read(key: keyGeminiApiKey);
  }

  @override
  Future<void> saveApiKey({required String apiKey}) {
    return _secureStorage.write(key: keyGeminiApiKey, value: apiKey);
  }

  @override
  Future<void> deleteApiKey() {
    return _secureStorage.delete(key: keyGeminiApiKey);
  }
}

class InMemoryAiKeyLocalDataSource implements AiKeyLocalDataSource {
  String? _savedApiKey;

  @override
  Future<String?> readApiKey() async {
    return _savedApiKey;
  }

  @override
  Future<void> saveApiKey({required String apiKey}) async {
    _savedApiKey = apiKey;
  }

  @override
  Future<void> deleteApiKey() async {
    _savedApiKey = null;
  }
}
