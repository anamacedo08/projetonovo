import '../../../../core/database/database_service.dart';

class ManageAttendantUseCase {
  final DatabaseService _dbService = DatabaseService();

  Future<void> criarAtendente(Map<String, dynamic> dados) async {
    final db = await _dbService.database;
    
    // Validar campos obrigatórios
    if (dados['email'] == null || dados['email'].isEmpty) {
      throw Exception('Email é obrigatório');
    }
    if (dados['password'] == null || dados['password'].isEmpty) {
      throw Exception('Senha é obrigatória');
    }

    await db.insert('users', {
      'email': dados['email'],
      'password_hash': dados['password'], // Em produção, usar hash
      'role': 'ATENDENTE',
      'ativo': 1,
    });
  }

  Future<void> inativarAtendente(int id) async {
    final db = await _dbService.database;
    await db.update(
      'users',
      {'ativo': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
