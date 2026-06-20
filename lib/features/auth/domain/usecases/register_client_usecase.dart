import '../../../../core/database/database_service.dart';

class RegisterClientUseCase {
  final DatabaseService _dbService = DatabaseService();

  Future<void> executar(Map<String, dynamic> dadosCliente) async {
    final db = await _dbService.database;
    
    // Verificar se email já existe
    final List<Map<String, dynamic>> existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [dadosCliente['email']],
    );

    if (existing.isNotEmpty) {
      throw Exception('ErroConflito: Email já cadastrado');
    }

    // Hash simplificado conforme spec
    final String hash = dadosCliente['password']; // Em produção, encriptar

    await db.insert('users', {
      'email': dadosCliente['email'],
      'password_hash': hash,
      'role': 'CLIENTE',
    });
  }
}
