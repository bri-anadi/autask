class BuildTaskDraftPromptUseCase {
  const BuildTaskDraftPromptUseCase();

  String call({required String userPrompt}) {
    final String trimmedPrompt = userPrompt.trim();
    return '''
Anda adalah asisten produktivitas untuk aplikasi task management.
Ubah permintaan user menjadi SATU draft task terstruktur.
Balas HANYA dengan JSON object valid tanpa teks tambahan.
Skema JSON wajib:
{
  "title": "string, wajib, ringkas",
  "description": "string, opsional",
  "status": "todo | in progress | done",
  "priority": "high | medium | low",
  "due_date": "YYYY-MM-DD atau null"
}

Input user:
$trimmedPrompt
''';
  }
}
