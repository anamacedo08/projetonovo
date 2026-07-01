import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'database_schema.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  @visibleForTesting
  static Future<void> reset() async {
    if (_instance._database != null) {
      await _instance._database!.close();
      _instance._database = null;
    }
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inicializar();
    return _database!;
  }

  Future<Database> _inicializar() async {
    final dbName = dotenv.get('DB_NAME', fallback: 'artesanal.db');
    final dbVersion = int.parse(dotenv.get('DB_VERSION', fallback: '1'));
    
    String dbPath = join(await getDatabasesPath(), dbName);
    
    return await openDatabase(
      dbPath,
      version: dbVersion,
      onCreate: (db, version) async {
        await DatabaseSchema.createTables(db);
        await DatabaseSchema.seed(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await DatabaseSchema.createTables(db);
      },
      onOpen: (db) async {
        await DatabaseSchema.createTables(db);
      }
    );
  }
}
