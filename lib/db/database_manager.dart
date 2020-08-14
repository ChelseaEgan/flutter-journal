import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'journal_entry_dto.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static const String DATABASE_SCHEMA_PATH = 'assets/db_schema.txt';
  static const String SQL_INSERT =
      'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)';
  static const String SQL_SELECT = 'SELECT * FROM journal_entries';

  static DatabaseManager _instance;

  final Database db;

  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    String dbSchema = await rootBundle.loadString(DATABASE_SCHEMA_PATH);
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      createTables(db, dbSchema);
    });
    _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({JournalEntryDTO dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(
          SQL_INSERT, [dto.title, dto.body, dto.rating, dto.dateTime]);
    });
  }

  Future<List<Map<String, dynamic>>> journalEntries() {
    return db.rawQuery(SQL_SELECT);
  }
}
