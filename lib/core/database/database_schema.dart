import 'package:sqflite/sqflite.dart';

class DatabaseSchema {
  static Future<void> createTables(Database db) async {
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
  }

  static Future<void> seed(Database db) async {
    await _seedAdmin(db);
    await _seedProducts(db);
  }

  static Future<void> _seedAdmin(Database db) async {
    final List<Map<String, dynamic>> existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: ['admin@artesanal.com'],
    );
    if (existing.isEmpty) {
      await db.insert('users', {
        'role': 'admin',
        'email': 'admin@artesanal.com',
        'password_hash': '123',
        'ativo': 1
      });
    }
  }

  static Future<void> _seedProducts(Database db) async {
    final List<Map<String, dynamic>> existing = await db.query('products');
    if (existing.isEmpty) {
      final products = [
        {
          'nome': 'Vaso de Cerâmica',
          'descricao': 'Vaso feito à mão com acabamento rústico.',
          'imagem': 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61',
          'preco': 45.0
        },
        {
          'nome': 'Cesto de Palha',
          'descricao': 'Cesto trançado ideal para organização.',
          'imagem': 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61',
          'preco': 30.0
        },
        {
          'nome': 'Luminária de Macramê',
          'descricao': 'Luminária artesanal para ambientes modernos.',
          'imagem': 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61',
          'preco': 60.0
        }
      ];

      for (var p in products) {
        await db.insert('products', p);
      }
    }
  }
}
