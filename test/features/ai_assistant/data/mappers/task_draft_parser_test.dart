import 'package:autask/features/ai_assistant/data/mappers/task_draft_parser.dart';
import 'package:autask/features/ai_assistant/domain/entities/task_draft.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const TaskDraftParser parser = TaskDraftParser();

  test('parse success for clean json payload', () {
    const String response =
        '{"title":"Belajar Flutter","description":"Baca modul bloc","status":"todo","priority":"high","due_date":"2026-04-20"}';

    final TaskDraft result = parser.parse(responseText: response);

    expect(result.title, 'Belajar Flutter');
    expect(result.description, 'Baca modul bloc');
    expect(result.status, 'todo');
    expect(result.priority, 'high');
    expect(result.dueDate, DateTime.parse('2026-04-20'));
  });

  test('parse success when json wrapped in markdown code fence', () {
    const String response = '''
Berikut draft tugasmu:
```json
{
  "title": "Riset API Gemini",
  "description": "Uji timeout dan error handling",
  "priority": "medium"
}
```
''';

    final TaskDraft result = parser.parse(responseText: response);

    expect(result.title, 'Riset API Gemini');
    expect(result.description, 'Uji timeout dan error handling');
    expect(result.status, 'todo');
    expect(result.priority, 'medium');
    expect(result.dueDate, isNull);
  });

  test('throws when title is missing', () {
    const String response = '{"description":"Tanpa judul"}';

    expect(
      () => parser.parse(responseText: response),
      throwsA(
        isA<TaskDraftParseException>().having(
          (TaskDraftParseException exception) => exception.message,
          'message',
          'Field title wajib diisi.',
        ),
      ),
    );
  });

  test('throws when status enum invalid', () {
    const String response =
        '{"title":"Task A","status":"pending","priority":"low"}';

    expect(
      () => parser.parse(responseText: response),
      throwsA(
        isA<TaskDraftParseException>().having(
          (TaskDraftParseException exception) => exception.message,
          'message',
          contains('Nilai status tidak valid'),
        ),
      ),
    );
  });

  test('throws when priority enum invalid', () {
    const String response =
        '{"title":"Task B","status":"done","priority":"urgent"}';

    expect(
      () => parser.parse(responseText: response),
      throwsA(
        isA<TaskDraftParseException>().having(
          (TaskDraftParseException exception) => exception.message,
          'message',
          contains('Nilai priority tidak valid'),
        ),
      ),
    );
  });

  test('throws when due date is invalid', () {
    const String response =
        '{"title":"Task C","status":"todo","priority":"medium","due_date":"31-12-2026"}';

    expect(
      () => parser.parse(responseText: response),
      throwsA(
        isA<TaskDraftParseException>().having(
          (TaskDraftParseException exception) => exception.message,
          'message',
          'Format due_date tidak valid.',
        ),
      ),
    );
  });

  test('throws when no json object found in response', () {
    const String response = 'Saya tidak bisa membuat draft sekarang.';

    expect(
      () => parser.parse(responseText: response),
      throwsA(
        isA<TaskDraftParseException>().having(
          (TaskDraftParseException exception) => exception.message,
          'message',
          'JSON task draft tidak ditemukan.',
        ),
      ),
    );
  });
}
