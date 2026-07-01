import '../repositories/user_repository.dart';

class RegisterClientUseCase {
  final UserRepository _repository = UserRepository();

  Future<void> executar(Map<String, dynamic> dadosCliente) async {
    final existing = await _repository.findByEmail(dadosCliente['email']);

    if (existing != null) {
      throw Exception('ErroConflito: Email já cadastrado');
    }

    await _repository.insert({
      'email': dadosCliente['email'],
      'password_hash': dadosCliente['password'],
      'role': 'CLIENTE',
      'ativo': 1,
    });
  }
}
