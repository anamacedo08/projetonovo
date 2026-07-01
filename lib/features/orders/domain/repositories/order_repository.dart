import '../../../../core/database/base_repository.dart';

class OrderRepository extends BaseRepository {
  OrderRepository() : super('orders');

  Future<List<Map<String, dynamic>>> findByClientId(int clientId) async {
    return await query(where: 'cliente_id = ?', whereArgs: [clientId], orderBy: 'data_criacao DESC');
  }
}
