import 'package:flutter_test/flutter_test.dart';
import 'package:projetonovo/core/services/auth_service.dart';
import 'package:projetonovo/core/database/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';

void main() {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    try { await dotenv.load(); } catch (_) {}
  });

  setUp(() async {
    final dbPath = join(await getDatabasesPath(), 'artesanal.db');
    await DatabaseService.reset();
    await deleteDatabase(dbPath);
  });

  group('DatabaseService Tests', () {
    test('Database should initialize and seed admin and 3 products', () async {
      final dbService = DatabaseService();
      final db = await dbService.database;
      
      final List<Map<String, dynamic>> users = await db.query('users', where: 'email = ?', whereArgs: ['admin@artesanal.com']);
      expect(users.length, 1);
      
      final List<Map<String, dynamic>> products = await db.query('products');
      expect(products.length, 3);
    });
  });

  group('AuthService Tests', () {
    test('Login should succeed with correct credentials', () async {
      final authService = AuthService();
      final success = await authService.login('admin@artesanal.com', 'senhaPadraoHash');
      expect(success, true);
      expect(authService.obterNivelAcesso(), 'ADMIN');
    });

    test('Login should fail with incorrect credentials', () async {
      final authService = AuthService();
      final success = await authService.login('admin@artesanal.com', 'wrongpassword');
      expect(success, false);
      expect(authService.obterNivelAcesso(), 'VISITANTE');
    });
  });
}
