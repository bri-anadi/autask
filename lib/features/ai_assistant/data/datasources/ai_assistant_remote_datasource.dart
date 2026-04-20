import 'dart:async';
import 'dart:convert';
import 'dart:io';

class AiAssistantRequestException implements Exception {
  const AiAssistantRequestException(this.message);

  final String message;
}

abstract class AiAssistantRemoteDataSource {
  Future<String> sendPrompt({required String apiKey, required String prompt});
}

class GeminiAiAssistantRemoteDataSource implements AiAssistantRemoteDataSource {
  GeminiAiAssistantRemoteDataSource({
    HttpClient? httpClient,
    this.model = 'gemini-3-flash-preview',
    this.timeout = const Duration(seconds: 20),
  }) : _httpClient = httpClient ?? HttpClient();

  final HttpClient _httpClient;
  final String model;
  final Duration timeout;

  @override
  Future<String> sendPrompt({
    required String apiKey,
    required String prompt,
  }) async {
    final Uri uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
    );

    final HttpClientRequest request;
    try {
      request = await _httpClient.postUrl(uri).timeout(timeout);
    } on SocketException {
      throw const AiAssistantRequestException(
        'Koneksi internet tidak tersedia.',
      );
    } on HttpException {
      throw const AiAssistantRequestException(
        'Gagal menghubungkan ke layanan AI.',
      );
    } on TimeoutException {
      throw const AiAssistantRequestException(
        'Permintaan AI melebihi batas waktu.',
      );
    }

    request.headers.contentType = ContentType.json;
    request.write(
      jsonEncode(<String, dynamic>{
        'contents': <Map<String, dynamic>>[
          <String, dynamic>{
            'parts': <Map<String, String>>[
              <String, String>{'text': prompt},
            ],
          },
        ],
      }),
    );

    final HttpClientResponse response;
    try {
      response = await request.close().timeout(timeout);
    } on TimeoutException {
      throw const AiAssistantRequestException(
        'Permintaan AI melebihi batas waktu.',
      );
    } on SocketException {
      throw const AiAssistantRequestException('Koneksi internet tidak stabil.');
    }

    final String responseBody = await response.transform(utf8.decoder).join();
    final Map<String, dynamic> json =
        jsonDecode(responseBody) as Map<String, dynamic>;

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final String apiError = _readApiError(json: json);
      throw AiAssistantRequestException(apiError);
    }

    final String? text = _readCandidateText(json: json);
    if (text == null || text.trim().isEmpty) {
      throw const AiAssistantRequestException('Respons AI kosong. Coba lagi.');
    }

    return text.trim();
  }

  String _readApiError({required Map<String, dynamic> json}) {
    final Object? errorObject = json['error'];
    if (errorObject is Map<String, dynamic>) {
      final Object? message = errorObject['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
    }

    return 'Terjadi kesalahan saat menghubungi layanan AI.';
  }

  String? _readCandidateText({required Map<String, dynamic> json}) {
    final Object? candidatesObject = json['candidates'];
    if (candidatesObject is! List<dynamic> || candidatesObject.isEmpty) {
      return null;
    }

    final Object? firstCandidate = candidatesObject.first;
    if (firstCandidate is! Map<String, dynamic>) {
      return null;
    }

    final Object? contentObject = firstCandidate['content'];
    if (contentObject is! Map<String, dynamic>) {
      return null;
    }

    final Object? partsObject = contentObject['parts'];
    if (partsObject is! List<dynamic> || partsObject.isEmpty) {
      return null;
    }

    final Object? firstPart = partsObject.first;
    if (firstPart is! Map<String, dynamic>) {
      return null;
    }

    final Object? textObject = firstPart['text'];
    return textObject is String ? textObject : null;
  }
}

class InMemoryAiAssistantRemoteDataSource
    implements AiAssistantRemoteDataSource {
  InMemoryAiAssistantRemoteDataSource({
    this.responseText = 'Draft tugas berhasil dibuat.',
    this.errorMessage,
    this.delay = Duration.zero,
  });

  final String responseText;
  final String? errorMessage;
  final Duration delay;

  @override
  Future<String> sendPrompt({
    required String apiKey,
    required String prompt,
  }) async {
    if (delay != Duration.zero) {
      await Future<void>.delayed(delay);
    }

    if (errorMessage != null) {
      throw AiAssistantRequestException(errorMessage!);
    }

    return responseText;
  }
}
