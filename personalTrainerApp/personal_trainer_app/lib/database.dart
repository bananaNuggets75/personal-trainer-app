import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  // Singleton instance
  static DatabaseHelper get instance => _singleton;

  // Database instance
  Database? _database;

  // Private constructor
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'app_database.db');
    return databaseFactoryIo.openDatabase(dbPath);
  }

  final _userStore = intMapStoreFactory.store('users');
  final _goalStore = intMapStoreFactory.store('goals');
  final _sessionStore = intMapStoreFactory.store('sessions');

  // User CRUD
  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await database;
    return await _userStore.add(db, row);
  }

  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    final db = await database;
    final finder = Finder(
      filter: Filter.and([
        Filter.equals('username', username),
        Filter.equals('password', password),
      ]),
    );
    final recordSnapshots = await _userStore.find(db, finder: finder);
    if (recordSnapshots.isNotEmpty) {
      return recordSnapshots.first.value;
    }
    return null;
  }

  // Goal CRUD
  Future<int> insertGoal(Map<String, dynamic> row) async {
    final db = await database;
    return await _goalStore.add(db, row);
  }

  Future<List<Map<String, dynamic>>> queryAllGoals() async {
    final db = await database;
    final recordSnapshots = await _goalStore.find(db);
    return recordSnapshots.map((snapshot) => snapshot.value).toList();
  }

  Future<int> updateGoal(Map<String, dynamic> row) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(row['id']));
    return await _goalStore.update(db, row, finder: finder);
  }

  Future<int> deleteGoal(int id) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(id));
    return await _goalStore.delete(db, finder: finder);
  }

  // Session CRUD
  Future<int> insertSession(Map<String, dynamic> row) async {
    final db = await database;
    return await _sessionStore.add(db, row);
  }

  Future<List<Map<String, dynamic>>> queryAllSessions() async {
    final db = await database;
    final recordSnapshots = await _sessionStore.find(db);
    return recordSnapshots.map((snapshot) => snapshot.value).toList();
  }

  Future<int> updateSession(Map<String, dynamic> row) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(row['id']));
    return await _sessionStore.update(db, row, finder: finder);
  }

  Future<int> deleteSession(int id) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(id));
    return await _sessionStore.delete(db, finder: finder);
  }
}
