import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class TaskDatabase {
  TaskDatabase._();

  static const String databaseName = 'autask.db';
  static const int databaseVersion = 1;
  static const String taskTable = 'tasks';

  static Database? _database;

  static Future<Database> get instance async {
    if (_database != null) {
      return _database!;
    }

    final String dbPath = await getDatabasesPath();
    final String fullPath = path.join(dbPath, databaseName);

    _database = await openDatabase(
      fullPath,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _database!;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $taskTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL DEFAULT '',
        status TEXT NOT NULL DEFAULT 'todo',
        due_date TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Reserved for future migrations.
  }
}
