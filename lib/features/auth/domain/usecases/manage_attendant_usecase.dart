import '../../../../core/database/database_service.dart';

class ManageAttendantUseCase {
  final DatabaseService _dbService = DatabaseService();

  Future<void> criarAtendente(Map<String, dynamic> dados) async {
    final db = await _dbService.database;
    
    // Supõe-se que a verificação de permissão Admin é feita na Controller/UI
    await db.insert('users', {
      'email': dados['email'],
      'password_hash': dados['password'],
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
