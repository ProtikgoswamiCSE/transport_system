import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'bus_routes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bus_routes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        busNumber TEXT,
        fromLocation TEXT,
        toLocation TEXT,
        date TEXT,
        time TEXT
      )
    ''');
  }

  Future<int> insertRoute(Map<String, dynamic> route) async {
    final db = await database;
    return await db.insert('bus_routes', {
      'busNumber': route['busNumber'],
      'fromLocation': route['from'],
      'toLocation': route['to'],
      'date': route['date'],
      'time': route['time'],
    });
  }

  Future<List<Map<String, dynamic>>> getAllRoutes() async {
    final db = await database;
    return await db.query('bus_routes');
  }

  Future<int> deleteRoute(int id) async {
    final db = await database;
    return await db.delete(
      'bus_routes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
