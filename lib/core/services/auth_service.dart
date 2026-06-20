import 'package:flutter/foundation.dart';
import '../database/database_service.dart';

class AuthService extends ChangeNotifier {
  Map<String, dynamic>? _usuarioAtual;

  Map<String, dynamic>? get usuarioAtual => _usuarioAtual;

  Future<bool> login(String email, String senha) async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      final user = maps.first;
      // Verificação de senha (comparação direta para este exemplo)
      if (user['password_hash'] == senha) {
        _usuarioAtual = user;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  String? obterNivelAcesso() {
    return _usuarioAtual?['role']?.toString().toUpperCase();
  }

  void logout() {
    _usuarioAtual = null;
    notifyListeners();
  }
}
