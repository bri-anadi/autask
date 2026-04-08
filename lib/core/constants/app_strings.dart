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
