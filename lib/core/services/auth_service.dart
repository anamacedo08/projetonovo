import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  Map<String, dynamic>? _usuarioAtual;

  Map<String, dynamic>? get usuarioAtual => _usuarioAtual;

  Future<bool> login(String email, String senha) async {
    // Simulação de busca no banco e validação de senha
    if (email == 'admin@artesanal.com' && senha == 'senhaPadrao') {
      _usuarioAtual = {
        'id': 1,
        'email': email,
        'role': 'ADMIN',
      };
      notifyListeners();
      return true;
    }
    return false;
  }

  String? obterNivelAcesso() {
    return _usuarioAtual?['role'];
  }

  void logout() {
    _usuarioAtual = null;
    notifyListeners();
  }
}
