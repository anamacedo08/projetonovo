import 'package:flutter/material.dart';
import '../../../../core/database/database_service.dart';
import '../../domain/usecases/manage_products_usecase.dart';

class AdminProductsPage extends StatefulWidget {
  const AdminProductsPage({super.key});

  @override
  State<AdminProductsPage> createState() => _AdminProductsPageState();
}

class _AdminProductsPageState extends State<AdminProductsPage> {
  final ManageProductsUseCase _useCase = ManageProductsUseCase();

  Future<List<Map<String, dynamic>>> _getProducts() async {
    final db = await DatabaseService().database;
    return await db.query('products', where: 'excluido = 0');
  }

  void _showAddProductDialog() {
    final nomeController = TextEditingController();
    final descricaoController = TextEditingController();
    final precoController = TextEditingController();
    final imagemController = TextEditingController(); // Novo campo: Link da imagem

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo Produto'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
              TextField(controller: descricaoController, decoration: const InputDecoration(labelText: 'Descrição')),
              TextField(controller: precoController, decoration: const InputDecoration(labelText: 'Preço'), keyboardType: TextInputType.number),
              TextField(controller: imagemController, decoration: const InputDecoration(labelText: 'Link da Imagem (URL)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              await _useCase.salvarProduto({
                'nome': nomeController.text,
                'descricao': descricaoController.text,
                'preco': double.tryParse(precoController.text) ?? 0.0,
                'imagem': imagemController.text.isNotEmpty ? imagemController.text : 'assets/placeholder.png',
              });
              if (mounted) {
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão de Produtos')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          final products = snapshot.data ?? [];
          if (products.isEmpty) return const Center(child: Text('Nenhum produto cadastrado.'));
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: (p['imagem'] != null && p['imagem'].toString().startsWith('http'))
                    ? Image.network(p['imagem'], errorBuilder: (_, __, ___) => const Icon(Icons.broken_image))
                    : const Icon(Icons.image),
                ),
                title: Text(p['nome']),
                subtitle: Text('R\$ ${p['preco']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await _useCase.exclusaoLogica(p['id']);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
