import 'package:autask/features/ai_assistant/domain/entities/task_draft.dart';
import 'package:autask/features/ai_assistant/domain/services/task_draft_extractor.dart';

class ExtractTaskDraftUseCase {
  const ExtractTaskDraftUseCase(this._extractor);

  final TaskDraftExtractor _extractor;

  TaskDraft call({required String responseText}) {
    return _extractor.extract(responseText: responseText);
  }
}
