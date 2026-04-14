class AppStrings {
  const AppStrings._();

  static const String appName = 'Autask';
  static const String taskPageTitle = 'Daftar Tugas';
  static const String taskPageSubtitle = 'Tambah dan kelola tugas harian Anda';
  static const String addTaskButton = 'Tambah Tugas';
  static const String addTaskDialogTitle = 'Tugas Baru';
  static const String editTaskDialogTitle = 'Edit Tugas';
  static const String taskDetailTitle = 'Detail Tugas';
  static const String titleLabel = 'Judul';
  static const String descriptionLabel = 'Deskripsi';
  static const String statusLabel = 'Status';
  static const String priorityLabel = 'Prioritas';
  static const String dueDateLabel = 'Deadline';
  static const String noDueDateLabel = 'Tidak ada deadline';
  static const String filterLabel = 'Filter';
  static const String sortLabel = 'Urutkan';
  static const String saveLabel = 'Simpan';
  static const String cancelLabel = 'Batal';
  static const String clearDateLabel = 'Hapus Tanggal';
  static const String chooseDateLabel = 'Pilih Tanggal';
  static const String emptyTaskMessage =
      'Belum ada tugas. Tambahkan tugas pertama Anda.';
  static const String deleteTaskLabel = 'Hapus tugas';
  static const String editTaskLabel = 'Edit tugas';
  static const String quickStatusLabel = 'Ubah status cepat';
  static const String aiSettingsLabel = 'Pengaturan AI';

  static const String aiSettingsTitle = 'Pengaturan';
  static const String aiSettingsDescription =
      'Masukkan API key Gemini Anda sendiri. Kunci disimpan aman di secure storage perangkat dan tidak di-hardcode di source code.';
  static const String aiApiKeyLabel = 'API Key Gemini';
  static const String aiApiKeyHint = 'Contoh: AIza...';
  static const String aiSaveKeyButton = 'Simpan API Key';
  static const String aiDeleteKeyButton = 'Hapus API Key';
  static const String aiSavedKeyTitle = 'API Key Tersimpan (Masked)';
  static const String aiNoSavedKeyLabel =
      'Belum ada API key tersimpan di perangkat.';

  static const String aiLoadKeyError = 'Gagal memuat API key tersimpan';
  static const String aiSaveKeyError = 'Gagal menyimpan API key';
  static const String aiDeleteKeyError = 'Gagal menghapus API key';
  static const String aiSaveKeySuccess = 'API key berhasil disimpan';
  static const String aiDeleteKeySuccess = 'API key berhasil dihapus';
  static const String aiValidationEmptyKey = 'API key tidak boleh kosong';
  static const String aiValidationNoSpaces =
      'API key tidak boleh mengandung spasi';
  static const String aiValidationMinimumLength = 'API key minimal 20 karakter';
  static const String aiValidationPrefix =
      'Format API key tidak valid (harus diawali AIza)';

  static const String aiAssistantTitle = 'Asisten AI';
  static const String aiAssistantNavLabel = 'Asisten';
  static const String aiAssistantInputHint = 'Tulis perintah atau ide tugas...';
  static const String aiAssistantEmptyState =
      'Belum ada percakapan. Mulai dengan menulis prompt di bawah.';
  static const String aiAssistantLoading =
      'Asisten sedang menyiapkan respons...';
  static const String aiAssistantDraftReady = 'Draft task terdeteksi';
  static const String aiAssistantDraftFallback =
      'Respons AI belum dapat diparse ke draft task.';
  static const String aiAssistantReviewDraftButton = 'Tinjau Draft';
  static const String aiAssistantManualDraftButton = 'Buat Manual';
  static const String aiAssistantConfirmSheetTitle = 'Konfirmasi Draft Task';
  static const String aiAssistantManualSheetTitle = 'Buat Task Manual';
  static const String aiAssistantSaveDraftButton = 'Simpan ke Task';
  static const String aiAssistantSaveDraftSuccess =
      'Draft task berhasil disimpan.';
  static const String aiAssistantSaveManualSuccess =
      'Task manual berhasil disimpan.';
  static const String aiPromptEmptyError = 'Prompt tidak boleh kosong';
  static const String aiMissingKeyError =
      'API key Gemini belum tersedia. Simpan dulu di Pengaturan.';
  static const String aiGenericError =
      'Terjadi kesalahan saat memproses permintaan AI.';

  static const String todoStatus = 'todo';
  static const String inProgressStatus = 'in progress';
  static const String doneStatus = 'done';

  static const String highPriority = 'high';
  static const String mediumPriority = 'medium';
  static const String lowPriority = 'low';

  static const String allFilterValue = 'all';

  static const String sortLatestValue = 'latest';
  static const String sortPriorityValue = 'priority';
  static const String sortDueDateValue = 'due_date';

  static const String loadTaskError = 'Gagal memuat data tugas';
  static const String addTaskError = 'Gagal menambahkan tugas';
  static const String updateTaskError = 'Gagal memperbarui tugas';
  static const String deleteTaskError = 'Gagal menghapus tugas';
  static const String emptyTitleError = 'Judul tugas tidak boleh kosong';

  static String statusText({required String status}) {
    switch (status) {
      case todoStatus:
        return 'To Do';
      case inProgressStatus:
        return 'In Progress';
      case doneStatus:
        return 'Done';
      default:
        return status;
    }
  }

  static String priorityText({required String priority}) {
    switch (priority) {
      case highPriority:
        return 'Tinggi';
      case mediumPriority:
        return 'Sedang';
      case lowPriority:
        return 'Rendah';
      default:
        return priority;
    }
  }

  static String nextStatusText({required String status}) {
    switch (status) {
      case todoStatus:
        return 'Ke In Progress';
      case inProgressStatus:
        return 'Ke Done';
      default:
        return 'Ke To Do';
    }
  }
}
