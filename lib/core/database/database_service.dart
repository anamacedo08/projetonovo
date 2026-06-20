import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

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
    
    String path = join(await getDatabasesPath(), dbName);
    
    // Deletar o banco se ele estiver corrompido ou sem tabelas (opcional, para debug)
    // if (kDebugMode) await deleteDatabase(path);

    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await _executarScriptCriacaoTabelas(db);
        await _semearAdminRoot(db);
        await _semearProdutosVitrine(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _executarScriptsMigracao(db);
      },
      onOpen: (db) async {
        // Garantir tabelas
        await _executarScriptCriacaoTabelas(db);
      }
    );
  }

  Future<void> _executarScriptCriacaoTabelas(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        role TEXT,
        email TEXT UNIQUE,
        password_hash TEXT,
        ativo INTEGER DEFAULT 1
      )
    ''');
    
    await db.execute('''
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        imagem TEXT,
        preco REAL,
        excluido INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
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
    await db.insert('users', {
      'role': 'admin',
      'email': 'admin@artesanal.com',
      'password_hash': 'senhaPadraoHash' 
    });
  }

  Future<void> _semearProdutosVitrine(Database db) async {
    await db.insert('products', {
      'nome': 'Vaso de Cerâmica',
      'descricao': 'Vaso feito à mão com acabamento rústico.',
      'imagem': 'assets/vaso.png',
      'preco': 45.0
    });
    await db.insert('products', {
      'nome': 'Cesto de Palha',
      'descricao': 'Cesto trançado ideal para organização.',
      'imagem': 'assets/cesto.png',
      'preco': 30.0
    });
    await db.insert('products', {
      'nome': 'Luminária de Macramê',
      'descricao': 'Luminária artesanal para ambientes modernos.',
      'imagem': 'assets/luminaria.png',
      'preco': 60.0
    });
  }

  Future<void> _executarScriptsMigracao(Database db) async {
    // Implementar migrações se necessário
  }
}
