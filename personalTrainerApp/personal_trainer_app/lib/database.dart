import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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

  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    print('Results: $results');
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT
    )
    ''');

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

    // initial user
    await db.insert('users', {
      'username': 'ken',
      'password': '123'
    });
  }

  // User operations
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('users', row);
  }

  Future<Map<String, dynamic>?> getUsers(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  // CRUD operations for Goals
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

  // CRUD operations for Sessions
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
