import '../../../../core/database/database_service.dart';

class CreateOrderUseCase {
  final DatabaseService _dbService = DatabaseService();

  Future<void> executar(int clienteId, Map<String, dynamic> dadosPedido, Map<String, dynamic> dadosEntrega) async {
    final db = await _dbService.database;
    
    // Validações para Encomenda Sob Medida
    if (dadosPedido['descricao_pedido'] == null || dadosPedido['descricao_pedido'].isEmpty) {
      throw Exception('A descrição da sua encomenda é obrigatória');
    }
    if (dadosEntrega['endereco_entrega'] == null || dadosEntrega['endereco_entrega'].isEmpty) {
      throw Exception('Endereço de entrega é obrigatório');
    }
    if (dadosEntrega['numero_contato'] == null || dadosEntrega['numero_contato'].isEmpty) {
      throw Exception('Número de contato é obrigatório');
    }

    await db.insert('orders', {
      'cliente_id': clienteId,
      'status': 'AGUARDANDO_INICIO',
      'data_criacao': DateTime.now().toIso8601String(),
      'valor_total': 0.0, // O valor será definido após avaliação pelo artesão
      'descricao_pedido': dadosPedido['descricao_pedido'],
      'endereco_entrega': dadosEntrega['endereco_entrega'],
      'numero_contato': dadosEntrega['numero_contato'],
      'dados_logistica': 'AGUARDANDO AVALIAÇÃO',
    });
  }
}
