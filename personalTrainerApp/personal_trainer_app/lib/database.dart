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
    try {
      String path = join(await getDatabasesPath(), 'app_database.db');
      print('Database path: $path'); // Log database path
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onOpen: (db) {
          print('Database opened');
        },
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    try {
      Database db = await database;
      print('Querying user: $username');
      List<Map<String, dynamic>> results = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      print('Query results: $results'); // Log query results
      if (results.isNotEmpty) {
        return results.first;
      }
      return null;
    } catch (e) {
      print('Error querying user: $e');
      return null;
    }
  }

  Future _onCreate(Database db, int version) async {
    try {
      print('Creating database and tables');
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

      // Insert initial user
      int userId = await db.insert('users', {
        'username': 'testuser',
        'password': 'password123'
      });
      print('Inserted initial user with ID: $userId');
    } catch (e) {
      print('Error creating database or inserting initial data: $e');
    }
  }

  // User operations
  Future<int> insertUser(Map<String, dynamic> row) async {
    try {
      Database db = await database;
      return await db.insert('users', row);
    } catch (e) {
      print('Error inserting user: $e');
      return -1;
    }
  }

  Future<Map<String, dynamic>?> getUsers(String username, String password) async {
    try {
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
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // CRUD operations for Goals
  Future<int> insertGoal(Map<String, dynamic> row) async {
    try {
      Database db = await database;
      return await db.insert('goals', row);
    } catch (e) {
      print('Error inserting goal: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllGoals() async {
    try {
      Database db = await database;
      return await db.query('goals');
    } catch (e) {
      print('Error querying goals: $e');
      return [];
    }
  }

  Future<int> updateGoal(Map<String, dynamic> row) async {
    try {
      Database db = await database;
      int id = row['id'];
      return await db.update('goals', row, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error updating goal: $e');
      return -1;
    }
  }

  Future<int> deleteGoal(int id) async {
    try {
      Database db = await database;
      return await db.delete('goals', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting goal: $e');
      return -1;
    }
  }

  // CRUD operations for Sessions
  Future<int> insertSession(Map<String, dynamic> row) async {
    try {
      Database db = await database;
      return await db.insert('sessions', row);
    } catch (e) {
      print('Error inserting session: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllSessions() async {
    try {
      Database db = await database;
      return await db.query('sessions');
    } catch (e) {
      print('Error querying sessions: $e');
      return [];
    }
  }

  Future<int> updateSession(Map<String, dynamic> row) async {
    try {
      Database db = await database;
      int id = row['id'];
      return await db.update('sessions', row, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error updating session: $e');
      return -1;
    }
  }

  Future<int> deleteSession(int id) async {
    try {
      Database db = await database;
      return await db.delete('sessions', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting session: $e');
      return -1;
    }
  }
}
