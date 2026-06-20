import '../../../../core/services/notification_service.dart';

class UpdateOrderStatusUseCase {
  final NotificationService _notificationService = NotificationService();

  Future<void> executar(int idPedido, String novoStatus, {Map<String, dynamic>? dadosLogistica}) async {
    // pedido = OrderRepository.buscar(idPedido)

    // Lógica de transição de status simplificada
    print('Atualizando pedido $idPedido para status: $novoStatus');

    // NotificationService.enviarPush(pedido.clienteId, "Status atualizado para: " + novoStatus)
    await _notificationService.enviarPush(1, "Status atualizado para: $novoStatus");
  }
}
