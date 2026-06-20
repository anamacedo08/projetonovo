class GenerateSalesReportUseCase {
  Future<Map<String, dynamic>> executar(DateTime periodoInicial, DateTime periodoFinal) async {
    // verificarPermissaoAdmin()
    // pedidos = OrderRepository.buscarPorPeriodo(periodoInicial, periodoFinal)

    // faturamentoTotal = somar(pedidos.valor)
    // tempoMedio = calcularMedia(pedidos.dataEnvio - pedidos.dataIniciadaFabricacao)

    print('Gerando relatório de $periodoInicial até $periodoFinal');
    
    return {
      'faturamentoTotal': 1500.0,
      'tempoMedio': '2 dias',
      'pedidosConcluidos': 25
    };
  }
}
