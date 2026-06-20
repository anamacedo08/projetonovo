import 'package:flutter/foundation.dart';
import '../../../../core/database/database_service.dart';

enum OrderState { loading, completed, error }

class OrderController extends ChangeNotifier {
  OrderState estado = OrderState.loading;
  List<Map<String, dynamic>> pedidos = [];
  String? mensagemErro;

  final DatabaseService _dbService = DatabaseService();

  Future<void> carregarMeusPedidos(int usuarioId) async {
    estado = OrderState.loading;
    notifyListeners();

    try {
      final db = await _dbService.database;
      final List<Map<String, dynamic>> result = await db.query(
        'orders',
        where: 'cliente_id = ?',
        whereArgs: [usuarioId],
      );
      
      pedidos = result;
      estado = OrderState.completed;
    } catch (e) {
      estado = OrderState.error;
      mensagemErro = e.toString();
    }

    notifyListeners();
  }
}
