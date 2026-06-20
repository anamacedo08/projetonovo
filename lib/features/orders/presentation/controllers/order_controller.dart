import 'package:flutter/foundation.dart';

enum OrderState { loading, completed, error }

class OrderController extends ChangeNotifier {
  OrderState _estado = OrderState.completed;
  List<dynamic> _pedidos = [];

  OrderState get estado => _estado;
  List<dynamic> get pedidos => _pedidos;

  Future<void> carregarMeusPedidos(int usuarioId) async {
    _estado = OrderState.loading;
    notifyListeners();

    // Simulação de chamada ao UseCase
    // resultado = GetOrdersUseCase.executar(usuarioId)
    await Future.delayed(const Duration(seconds: 1)); // Simular delay
    
    _pedidos = []; // Preencher com dados reais
    _estado = OrderState.completed;
    
    notifyListeners();
  }
}
