import '../repositories/user_repository.dart';

class ManageAttendantUseCase {
  final UserRepository _repository = UserRepository();

  Future<void> criarAtendente(Map<String, dynamic> dados) async {
    if (dados['email'] == null || dados['email'].isEmpty) {
      throw Exception('Email é obrigatório');
    }
    if (dados['password'] == null || dados['password'].isEmpty) {
      throw Exception('Senha é obrigatória');
    }

    await _repository.insert({
      'email': dados['email'],
      'password_hash': dados['password'],
      'role': 'ATENDENTE',
      'ativo': 1,
    });
  }

  Future<void> inativarAtendente(int id) async {
    await _repository.update(
      {'ativo': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
