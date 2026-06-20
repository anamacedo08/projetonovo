import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'artesanal.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _executarScriptCriacaoTabelas(db);
    await _semearAdminRoot(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implementar migrações aqui
  }

  Future<void> _executarScriptCriacaoTabelas(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        role TEXT,
        email TEXT UNIQUE,
        password_hash TEXT
      )
    ''');
    // Adicionar outras tabelas conforme necessário
  }

  Future<void> _semearAdminRoot(Database db) async {
    await db.insert('users', {
      'role': 'admin',
      'email': 'admin@artesanal.com',
      'password_hash': 'senhaPadraoHash', // Em produção, usar um hash real
    });
  }
}
