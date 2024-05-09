import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbAccess {
  static final DbAccess _instance = DbAccess._internal();

  DbAccess._internal();

  factory DbAccess() {
    return _instance;
  }

  static Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'saved.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {

        await db.execute('''
CREATE TABLE Saved (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    term TEXT
);
''');
        await db.execute('''
CREATE TABLE Translation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    saved_id INTEGER,
    featured BOOLEAN,
    text TEXT,
    pos TEXT,
    usage_frequency REAL,
    FOREIGN KEY (saved_id) REFERENCES Saved(id)
);
''');
        await db.execute('''
CREATE TABLE AudioLinks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    translation_id INTEGER,
    url TEXT,
    lang TEXT,
    FOREIGN KEY (translation_id) REFERENCES Translation(id)
);
''');
        await db.execute('''
CREATE TABLE Example (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    translation_id INTEGER,
    src TEXT,
    dst TEXT,
    FOREIGN KEY (translation_id) REFERENCES Translation(id)
);
''');
      },
    );
  }
}
