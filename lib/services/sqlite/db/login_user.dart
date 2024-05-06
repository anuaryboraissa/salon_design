import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoginUserDBHelper {
  LoginUserDBHelper._internal();
  static const _dbName = 'salon.db';
  static const _dbVersion = 1;

  static const tableName = 'users';
  static const columnId = 'id';
  static const columnEmail = 'email';
  static const columnFirstname = 'first_name';
  static const columnLastname = 'last_name';
  static const columnType = 'type';

 factory LoginUserDBHelper() {
    return _instance;
  }
  static final LoginUserDBHelper _instance  = LoginUserDBHelper._internal();



  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future _onCreate(Database db, int version) async {
  tableCreate(db);
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await _instance.database;
    tableCreate(db);
    return db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await _instance.database;
    tableCreate(db);
    return db.query(tableName);
  }


  Future<Map<String, dynamic>?> queryById(int id) async {
    Database db = await _instance.database;
    tableCreate(db);
    List<Map<String, dynamic>> results =
        await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);

    return results.isEmpty?null: results.single;
  }

  Future<int> update(Map<String, dynamic> row,int id) async {
    Database db = await _instance.database;
    tableCreate(db);
    return db.update(
      tableName,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await _instance.database;
     tableCreate(db);
    return db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
   
  tableCreate(Database db)async{
           await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnEmail TEXT NOT NULL,
      $columnFirstname TEXT NOT NULL,
      $columnLastname TEXT NOT NULL,
      $columnType TEXT NOT NULL
      )
      ''');
  }
}