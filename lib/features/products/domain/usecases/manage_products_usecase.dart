class ManageProductsUseCase {
  Future<void> salvarProduto(Map<String, dynamic> produto) async {
    // verificarPermissaoAdmin()
    // se produto.id nulo:
    //   ProductRepository.inserir(produto)
    // senao:
    //   ProductRepository.atualizar(produto)
    print('Salvando produto: ${produto['nome']}');
  }

  Future<void> exclusaoLogica(int id) async {
    // verificarPermissaoAdmin()
    // ProductRepository.atualizarStatus(id, excluido: verdadeiro)
    print('Excluindo produto: $id');
  }
}
