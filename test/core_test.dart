import 'package:flutter_test/flutter_test.dart';
import 'package:projetonovo/core/services/auth_service.dart';
import 'package:projetonovo/core/database/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

void main() {
  setUpAll(() async {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    
    // Load .env for tests - if it fails, fallbacks will be used
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {}
  });

  tearDownAll(() async {
    // Clean up test database
    final path = await getDatabasesPath();
    final dbFile = File('\$path/artesanal_test.db');
    if (await dbFile.exists()) {
      await dbFile.delete();
    }
  });

  group('DatabaseService Tests', () {
    test('Database should initialize and seed admin', () async {
      final dbService = DatabaseService();
      final db = await dbService.database;
      
      final List<Map<String, dynamic>> users = await db.query('users', where: 'email = ?', whereArgs: ['admin@artesanal.com']);
      expect(users.length, 1);
      expect(users.first['role'], 'admin');
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
      expect(authService.usuarioAtual, isNull);
    });
  });
}
