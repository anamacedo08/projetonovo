import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inicializar();
    return _database!;
  }

  Future<Database> _inicializar() async {
    final dbName = dotenv.get('DB_NAME', fallback: 'artesanal.db');
    final dbVersion = int.parse(dotenv.get('DB_VERSION', fallback: '1'));
    
    String path = join(await getDatabasesPath(), dbName);
    
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await _executarScriptCriacaoTabelas(db);
        await _semearAdminRoot(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _executarScriptsMigracao(db);
      },
    );
  }

  Future<void> _executarScriptCriacaoTabelas(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        role TEXT,
        email TEXT UNIQUE,
        password_hash TEXT,
        ativo INTEGER DEFAULT 1
      )
    ''');
    
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        preco REAL,
        excluido INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cliente_id INTEGER,
        status TEXT,
        data_criacao TEXT,
        data_inicio_fabricacao TEXT,
        data_envio TEXT,
        valor_total REAL,
        dados_logistica TEXT,
        FOREIGN KEY (cliente_id) REFERENCES users (id)
      )
    ''');
  }

  Future<void> _semearAdminRoot(Database db) async {
    // Nota: Em um sistema real, usaríamos um hash real para a senha.
    await db.insert('users', {
      'role': 'admin',
      'email': 'admin@artesanal.com',
      'password_hash': 'senhaPadraoHash' 
    });
  }

  Future<void> _executarScriptsMigracao(Database db) async {
    // Implementar migrações se necessário
  }
}
