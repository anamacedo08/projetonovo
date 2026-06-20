import '../../../../core/database/database_service.dart';

class ManageProductsUseCase {
  final DatabaseService _dbService = DatabaseService();

  Future<void> salvarProduto(Map<String, dynamic> produto) async {
    final db = await _dbService.database;
    
    if (produto['id'] == null) {
      await db.insert('products', {
        'nome': produto['nome'],
        'preco': produto['preco'],
        'excluido': 0,
      });
    } else {
      await db.update(
        'products',
        {
          'nome': produto['nome'],
          'preco': produto['preco'],
        },
        where: 'id = ?',
        whereArgs: [produto['id']],
      );
    }
  }

  Future<void> exclusaoLogica(int id) async {
    final db = await _dbService.database;
    await db.update(
      'products',
      {'excluido': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
