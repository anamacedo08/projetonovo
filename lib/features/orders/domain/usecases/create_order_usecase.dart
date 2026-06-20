class CreateOrderUseCase {
  Future<void> executar(Map<String, dynamic> dadosPedido, Map<String, dynamic> dadosEntrega) async {
    // validarParametrosPersonalizacao(dadosPedido)
    // validarEndereco(dadosEntrega)

    /*
    pedido = EntidadePedido(
      cliente: AuthService.usuarioAtual,
      produtos: dadosPedido.itens,
      endereco: dadosEntrega,
      status: 'AGUARDANDO_INICIO',
      dataCriacao: DateTime.now()
    )
    */

    // OrderRepository.salvar(pedido)
    print('Pedido criado para entrega em: ${dadosEntrega['rua']}');
  }
}
