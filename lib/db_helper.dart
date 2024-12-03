import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE recipes(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              preparation_time TEXT,
              ingredients TEXT,
              instructions TEXT
          )''',
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getRecipes() async {
    final db = await database;
    return await db.query('recipes', orderBy: 'id DESC');
  }

  Future<int> insertRecipe(Map<String, dynamic> recipe) async {
    final db = await database;
    return await db.insert('recipes', recipe);
  }

  Future<int> updateRecipe(int id, Map<String, dynamic> recipe) async {
    final db = await database;
    return await db.update('recipes', recipe, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteRecipe(int id) async {
    final db = await database;
    return await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }
}
