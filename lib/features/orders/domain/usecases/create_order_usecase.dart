import '../../../../core/database/database_service.dart';

class CreateOrderUseCase {
  final DatabaseService _dbService = DatabaseService();

  Future<void> executar(int clienteId, Map<String, dynamic> dadosPedido, Map<String, dynamic> dadosEntrega) async {
    final db = await _dbService.database;
    
    // Validações simplificadas
    if (dadosPedido['itens'] == null || (dadosPedido['itens'] as List).isEmpty) {
      throw Exception('Pedido sem itens');
    }
    if (dadosEntrega['rua'] == null) {
      throw Exception('Endereço inválido');
    }

    await db.insert('orders', {
      'cliente_id': clienteId,
      'status': 'AGUARDANDO_INICIO',
      'data_criacao': DateTime.now().toIso8601String(),
      'valor_total': dadosPedido['valor_total'],
      'dados_logistica': dadosEntrega.toString(), // Simplificado
    });
  }
}
