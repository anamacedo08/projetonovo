import '../repositories/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository _repository = OrderRepository();

  Future<void> executar(int clienteId, Map<String, dynamic> dadosPedido, Map<String, dynamic> dadosEntrega) async {
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

    await _repository.insert({
      'cliente_id': clienteId,
      'status': 'AGUARDANDO_INICIO',
      'data_criacao': DateTime.now().toIso8601String(),
      'valor_total': 0.0,
      'descricao_pedido': dadosPedido['descricao_pedido'],
      'endereco_entrega': dadosEntrega['endereco_entrega'],
      'numero_contato': dadosEntrega['numero_contato'],
      'dados_logistica': 'AGUARDANDO AVALIAÇÃO',
    });
  }
}
