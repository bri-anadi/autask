import 'dart:convert';

import 'package:autask/features/ai_assistant/domain/entities/task_draft.dart';
import 'package:autask/features/ai_assistant/domain/services/task_draft_extractor.dart';

class TaskDraftParseException implements Exception {
  const TaskDraftParseException(this.message);

  final String message;
}

class TaskDraftParser implements TaskDraftExtractor {
  const TaskDraftParser();

  static const Set<String> _allowedStatus = <String>{
    'todo',
    'in progress',
    'done',
  };
  static const Set<String> _allowedPriority = <String>{'high', 'medium', 'low'};

  @override
  TaskDraft extract({required String responseText}) {
    final String rawJson = _extractJsonObject(rawText: responseText);
    final Map<String, dynamic> json = _decodeMap(rawJson: rawJson);

    final String title = _readString(
      json: json,
      keys: const <String>['title', 'task_title'],
      requiredField: true,
    );
    final String description = _readString(
      json: json,
      keys: const <String>['description', 'task_description', 'notes'],
      requiredField: false,
    );

    final String status = _readEnum(
      json: json,
      keys: const <String>['status'],
      allowedValues: _allowedStatus,
      fallback: 'todo',
      fieldName: 'status',
    );

    final String priority = _readEnum(
      json: json,
      keys: const <String>['priority'],
      allowedValues: _allowedPriority,
      fallback: 'medium',
      fieldName: 'priority',
    );

    final DateTime? dueDate = _readDate(
      json: json,
      keys: const <String>['due_date', 'dueDate', 'deadline'],
    );

    return TaskDraft(
      title: title,
      description: description,
      status: status,
      priority: priority,
      dueDate: dueDate,
    );
  }

  TaskDraft parse({required String responseText}) {
    return extract(responseText: responseText);
  }

  String _extractJsonObject({required String rawText}) {
    final String trimmed = rawText.trim();
    if (trimmed.isEmpty) {
      throw const TaskDraftParseException('Respons AI kosong.');
    }

    final String normalized = trimmed
        .replaceAll('```json', '')
        .replaceAll('```JSON', '')
        .replaceAll('```', '')
        .trim();

    final int startIndex = normalized.indexOf('{');
    if (startIndex == -1) {
      throw const TaskDraftParseException('JSON task draft tidak ditemukan.');
    }

    int depth = 0;
    int endIndex = -1;
    for (int i = startIndex; i < normalized.length; i++) {
      final String char = normalized[i];
      if (char == '{') {
        depth++;
      }
      if (char == '}') {
        depth--;
        if (depth == 0) {
          endIndex = i;
          break;
        }
      }
    }

    if (endIndex == -1) {
      throw const TaskDraftParseException('JSON task draft tidak lengkap.');
    }

    return normalized.substring(startIndex, endIndex + 1);
  }

  Map<String, dynamic> _decodeMap({required String rawJson}) {
    try {
      final Object? decoded = jsonDecode(rawJson);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw const TaskDraftParseException('Format JSON harus berupa object.');
    } on FormatException {
      throw const TaskDraftParseException('Format JSON tidak valid.');
    }
  }

  String _readString({
    required Map<String, dynamic> json,
    required List<String> keys,
    required bool requiredField,
  }) {
    for (final String key in keys) {
      final Object? value = json[key];
      if (value is String) {
        final String sanitized = value.trim();
        if (sanitized.isNotEmpty) {
          return sanitized;
        }
      }
    }

    if (requiredField) {
      throw const TaskDraftParseException('Field title wajib diisi.');
    }

    return '';
  }

  String _readEnum({
    required Map<String, dynamic> json,
    required List<String> keys,
    required Set<String> allowedValues,
    required String fallback,
    required String fieldName,
  }) {
    String? value;
    for (final String key in keys) {
      final Object? candidate = json[key];
      if (candidate is String && candidate.trim().isNotEmpty) {
        value = candidate.trim().toLowerCase();
        break;
      }
    }

    if (value == null) {
      return fallback;
    }

    if (!allowedValues.contains(value)) {
      throw TaskDraftParseException(
        'Nilai $fieldName tidak valid. Gunakan: ${allowedValues.join(', ')}.',
      );
    }

    return value;
  }

  DateTime? _readDate({
    required Map<String, dynamic> json,
    required List<String> keys,
  }) {
    for (final String key in keys) {
      final Object? value = json[key];
      if (value == null) {
        continue;
      }

      if (value is! String || value.trim().isEmpty) {
        throw const TaskDraftParseException(
          'Format due_date harus string ISO 8601.',
        );
      }

      final DateTime? parsed = DateTime.tryParse(value.trim());
      if (parsed == null) {
        throw const TaskDraftParseException('Format due_date tidak valid.');
      }

      return parsed;
    }

    return null;
  }
}
