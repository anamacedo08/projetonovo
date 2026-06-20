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
    
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await _executarScriptCriacaoTabelas(db);
        await _semearAdminRoot(db);
        await _semearProdutosVitrine(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _executarScriptCriacaoTabelas(db);
      },
      onOpen: (db) async {
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
        descricao_pedido TEXT,
        endereco_entrega TEXT,
        numero_contato TEXT,
        FOREIGN KEY (cliente_id) REFERENCES users (id)
      )
    ''');
    
    // Garantir que a coluna ativo existe na tabela users se ela já existia
    try {
      await db.execute('ALTER TABLE users ADD COLUMN ativo INTEGER DEFAULT 1');
    } catch (_) {}

    // Garantir que a coluna descricao_pedido existe se a tabela já existia (migração manual simplificada)
    try {
      await db.execute('ALTER TABLE orders ADD COLUMN descricao_pedido TEXT');
    } catch (_) {}
    try {
      await db.execute('ALTER TABLE orders ADD COLUMN endereco_entrega TEXT');
    } catch (_) {}
    try {
      await db.execute('ALTER TABLE orders ADD COLUMN numero_contato TEXT');
    } catch (_) {}
  }

  Future<void> _semearAdminRoot(Database db) async {
    final List<Map<String, dynamic>> existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: ['admin@artesanal.com'],
    );
    if (existing.isEmpty) {
      await db.insert('users', {
        'role': 'admin',
        'email': 'admin@artesanal.com',
        'password_hash': 'senhaPadraoHash',
        'ativo': 1
      });
    }
  }

  Future<void> _semearProdutosVitrine(Database db) async {
    final List<Map<String, dynamic>> existing = await db.query('products');
    if (existing.isEmpty) {
      await db.insert('products', {
        'nome': 'Vaso de Cerâmica',
        'descricao': 'Vaso feito à mão com acabamento rústico.',
        'imagem': 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61',
        'preco': 45.0
      });
      await db.insert('products', {
        'nome': 'Cesto de Palha',
        'descricao': 'Cesto trançado ideal para organização.',
        'imagem': 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61',
        'preco': 30.0
      });
      await db.insert('products', {
        'nome': 'Luminária de Macramê',
        'descricao': 'Luminária artesanal para ambientes modernos.',
        'imagem': 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61',
        'preco': 60.0
      });
    }
  }

  Future<void> _executarScriptsMigracao(Database db) async {
  }
}
