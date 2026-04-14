import 'package:autask/features/ai_assistant/domain/entities/task_draft.dart';

abstract class TaskDraftExtractor {
  TaskDraft extract({required String responseText});
}
