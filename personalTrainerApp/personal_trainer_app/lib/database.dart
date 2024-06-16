import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        targetDate TEXT,
        progressMetrics TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sessionType TEXT,
        coachInstructor TEXT,
        date TEXT,
        time TEXT
      )
    ''');
  }

  Future<int> insertGoal(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('goals', row);
  }

  Future<List<Map<String, dynamic>>> queryAllGoals() async {
    Database db = await database;
    return await db.query('goals');
  }

  Future<int> updateGoal(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('goals', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteGoal(int id) async {
    Database db = await database;
    return await db.delete('goals', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertSession(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('sessions', row);
  }

  Future<List<Map<String, dynamic>>> queryAllSessions() async {
    Database db = await database;
    return await db.query('sessions');
  }

  Future<int> updateSession(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('sessions', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteSession(int id) async {
    Database db = await database;
    return await db.delete('sessions', where: 'id = ?', whereArgs: [id]);
  }
}
