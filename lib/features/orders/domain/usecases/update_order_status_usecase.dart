import '../../../../core/database/database_service.dart';
import '../../../../core/services/notification_service.dart';

class UpdateOrderStatusUseCase {
  final DatabaseService _dbService = DatabaseService();
  final NotificationService _notificationService = NotificationService();

  Future<void> executar(int idPedido, String novoStatus, {Map<String, dynamic>? dadosLogistica}) async {
    final db = await _dbService.database;
    
    final List<Map<String, dynamic>> orders = await db.query(
      'orders',
      where: 'id = ?',
      whereArgs: [idPedido],
    );

    if (orders.isEmpty) throw Exception('Pedido não encontrado');
    
    final pedido = orders.first;
    final statusAtual = pedido['status'];

    bool transicaoValida = false;

    if (statusAtual == 'AGUARDANDO_INICIO' && novoStatus == 'EM_FABRICACAO') {
      transicaoValida = true;
    } else if (statusAtual == 'EM_FABRICACAO' && novoStatus == 'ENVIADO') {
      if (dadosLogistica == null || dadosLogistica['rastreio'] == null) {
        throw Exception('Dados de logística obrigatórios para envio');
      }
      transicaoValida = true;
    }

    if (!transicaoValida) {
      throw Exception('ErroTransicaoInvalida: Transição de $statusAtual para $novoStatus não permitida');
    }

    await db.update(
      'orders',
      {
        'status': novoStatus,
        'dados_logistica': dadosLogistica?.toString() ?? pedido['dados_logistica'],
      },
      where: 'id = ?',
      whereArgs: [idPedido],
    );

    await _notificationService.enviarPush(pedido['cliente_id'], "Status atualizado para: $novoStatus");
  }
}
