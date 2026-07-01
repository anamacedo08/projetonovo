import '../../../../core/database/database_service.dart';

class GenerateSalesReportUseCase {
  final DatabaseService _dbService = DatabaseService();

  Future<Map<String, dynamic>> executar(DateTime periodoInicial, DateTime periodoFinal) async {
    final db = await _dbService.database;
    
    final List<Map<String, dynamic>> orders = await db.query('orders');

    int totalPedidos = orders.length;
    int emAnalise = 0;
    int emFabricacao = 0;
    int enviados = 0;
    double faturamentoTotal = 0;

    for (var order in orders) {
      faturamentoTotal += (order['valor_total'] as num?)?.toDouble() ?? 0.0;
      
      final status = order['status'];
      if (status == 'AGUARDANDO_INICIO') {
        emAnalise++;
      } else if (status == 'EM_FABRICACAO') {
        emFabricacao++;
      } else if (status == 'ENVIADO') {
        enviados++;
      }
    }

    return {
      'total': totalPedidos,
      'emAnalise': emAnalise,
      'emFabricacao': emFabricacao,
      'enviados': enviados,
      'faturamentoTotal': faturamentoTotal,
    };
  }
}
