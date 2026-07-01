import '../repositories/product_repository.dart';

class ManageProductsUseCase {
  final ProductRepository _repository = ProductRepository();

  Future<void> salvarProduto(Map<String, dynamic> produto) async {
    if (produto['id'] == null) {
      await _repository.insert({
        'nome': produto['nome'],
        'descricao': produto['descricao'],
        'preco': produto['preco'],
        'imagem': produto['imagem'],
        'excluido': 0,
      });
    } else {
      await _repository.update(
        {
          'nome': produto['nome'],
          'descricao': produto['descricao'],
          'preco': produto['preco'],
          'imagem': produto['imagem'],
        },
        where: 'id = ?',
        whereArgs: [produto['id']],
      );
    }
  }

  Future<void> exclusaoLogica(int id) async {
    await _repository.update(
      {'excluido': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
