import 'package:flutter/foundation.dart';
import '../../features/auth/domain/repositories/user_repository.dart';

class AuthService extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  Map<String, dynamic>? _usuarioAtual;

  Map<String, dynamic>? get usuarioAtual => _usuarioAtual;

  Future<bool> login(String email, String senha) async {
    final user = await _userRepository.findByEmail(email);

    if (user != null) {
      if (user['password_hash'] == senha) {
        _usuarioAtual = user;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  String obterNivelAcesso() {
    return _usuarioAtual?['role']?.toString().toUpperCase() ?? 'VISITANTE';
  }

  void logout() {
    _usuarioAtual = null;
    notifyListeners();
  }
}
